import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flag_data.dart';

class FlagStorageService {
  static final FlagStorageService instance = FlagStorageService._internal();
  FlagStorageService._internal();

  Directory? _flagsDir;
  bool _isInitialized = false;

  final ValueNotifier<double> downloadProgress = ValueNotifier<double>(0.0);
  final ValueNotifier<bool> isDownloading = ValueNotifier<bool>(false);
  final ValueNotifier<int> savedCount = ValueNotifier<int>(0);
  final ValueNotifier<int> totalCount = ValueNotifier<int>(0);

  /// Safe local filename for an image URL
  String _getFileName(String url) {
    final uri = Uri.parse(url);
    final segments = uri.pathSegments;
    if (segments.isNotEmpty) {
      final last = segments.last;
      if (url.contains('map')) {
        return 'map_$last';
      }
      return 'flag_$last';
    }
    return 'img_${url.hashCode}.png';
  }

  /// Initialize local private flags directory
  Future<void> init() async {
    if (_isInitialized && _flagsDir != null) return;
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      _flagsDir = Directory('${appDocDir.path}/flags');
      if (!await _flagsDir!.exists()) {
        await _flagsDir!.create(recursive: true);
      }
      _isInitialized = true;
      await updateSavedCount();
    } catch (e) {
      debugPrint('Error initializing FlagStorageService: $e');
    }
  }

  /// Get local File reference asynchronously if it exists and is not empty
  Future<File?> getLocalImageFile(String url) async {
    await init();
    if (_flagsDir == null) return null;
    final fileName = _getFileName(url);
    final file = File('${_flagsDir!.path}/$fileName');
    if (await file.exists()) {
      final length = await file.length();
      if (length > 0) {
        return file;
      }
    }
    return null;
  }

  /// Synchronous check if file exists locally
  File? getLocalImageFileSync(String url) {
    if (_flagsDir == null) return null;
    final fileName = _getFileName(url);
    final file = File('${_flagsDir!.path}/$fileName');
    if (file.existsSync() && file.lengthSync() > 0) {
      return file;
    }
    return null;
  }

  /// Save raw bytes for a URL directly to private app storage
  Future<File?> saveImageBytes(String url, Uint8List bytes) async {
    await init();
    if (_flagsDir == null || bytes.isEmpty) return null;
    try {
      final fileName = _getFileName(url);
      final file = File('${_flagsDir!.path}/$fileName');
      await file.writeAsBytes(bytes, flush: true);
      updateSavedCount();
      return file;
    } catch (e) {
      debugPrint('Error saving image bytes for $url: $e');
      return null;
    }
  }

  /// Download single image and save to private app storage
  Future<File?> downloadAndSaveImage(String url) async {
    final existing = await getLocalImageFile(url);
    if (existing != null) return existing;

    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
        return await saveImageBytes(url, response.bodyBytes);
      }
    } catch (e) {
      debugPrint('Failed to download image $url: $e');
    }
    return null;
  }

  /// Count how many flags/maps are saved locally
  Future<int> updateSavedCount() async {
    await init();
    if (_flagsDir == null) return 0;

    int count = 0;
    try {
      final list = _flagsDir!.listSync();
      for (var entity in list) {
        if (entity is File && entity.lengthSync() > 0) {
          count++;
        }
      }
    } catch (e) {
      debugPrint('Error counting saved flags: $e');
    }

    savedCount.value = count;
    totalCount.value = FlagRepository.flags.length;
    return count;
  }

  /// Preload all flags in background when connected to internet
  Future<void> preloadAllFlags({bool force = false}) async {
    if (isDownloading.value) return;

    await init();
    if (_flagsDir == null) return;

    final Set<String> urlsToDownload = {};
    for (var item in FlagRepository.flags) {
      if (item.flagUrl.isNotEmpty) urlsToDownload.add(item.flagUrl);
      if (item.mapUrl.isNotEmpty) urlsToDownload.add(item.mapUrl);
    }

    final List<String> missingUrls = [];
    for (var url in urlsToDownload) {
      final file = getLocalImageFileSync(url);
      if (force || file == null) {
        missingUrls.add(url);
      }
    }

    if (missingUrls.isEmpty) {
      downloadProgress.value = 1.0;
      isDownloading.value = false;
      await updateSavedCount();
      return;
    }

    isDownloading.value = true;
    int completed = urlsToDownload.length - missingUrls.length;
    int total = urlsToDownload.length;
    downloadProgress.value = completed / total;

    // Concurrent batching (8 requests at a time)
    const int batchSize = 8;
    for (int i = 0; i < missingUrls.length; i += batchSize) {
      final batch = missingUrls.sublist(
        i,
        i + batchSize > missingUrls.length ? missingUrls.length : i + batchSize,
      );

      await Future.wait(batch.map((url) async {
        await downloadAndSaveImage(url);
        completed++;
        downloadProgress.value = completed / total;
      }));

      await Future.delayed(const Duration(milliseconds: 40));
    }

    isDownloading.value = false;
    await updateSavedCount();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('offline_flags_downloaded', true);
  }
}
