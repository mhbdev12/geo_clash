import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'flag_storage_service.dart';

class OfflineFlagImage extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String? cacheKey;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  final String? countryName;

  const OfflineFlagImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.cacheKey,
    this.placeholder,
    this.errorWidget,
    this.countryName,
  });

  @override
  State<OfflineFlagImage> createState() => _OfflineFlagImageState();
}

class _OfflineFlagImageState extends State<OfflineFlagImage> {
  File? _localFile;
  bool _isLoadingLocal = true;

  @override
  void initState() {
    super.initState();
    _checkLocalFile();
  }

  @override
  void didUpdateWidget(covariant OfflineFlagImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      _checkLocalFile();
    }
  }

  Future<void> _checkLocalFile() async {
    // Synchronous check first for instant rendering
    final syncFile = FlagStorageService.instance.getLocalImageFileSync(widget.imageUrl);
    if (syncFile != null) {
      if (mounted) {
        setState(() {
          _localFile = syncFile;
          _isLoadingLocal = false;
        });
      }
      return;
    }

    // Async check fallback
    final asyncFile = await FlagStorageService.instance.getLocalImageFile(widget.imageUrl);
    if (mounted) {
      setState(() {
        _localFile = asyncFile;
        _isLoadingLocal = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingLocal) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    // 1. Render from local private storage if file exists (100% offline ready)
    if (_localFile != null) {
      return Image.file(
        _localFile!,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        errorBuilder: (context, error, stackTrace) {
          return _buildDefaultErrorWidget(context);
        },
      );
    }

    // 2. Fallback to CachedNetworkImage (downloads & saves to private folder on success)
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      cacheKey: widget.cacheKey,
      placeholder: widget.placeholder ??
          (context, url) => const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
      imageBuilder: (context, imageProvider) {
        // Save copy to local disk in background for offline use
        FlagStorageService.instance.downloadAndSaveImage(widget.imageUrl);
        return Image(
          image: imageProvider,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
        );
      },
      errorWidget: widget.errorWidget ??
          (context, url, error) => _buildDefaultErrorWidget(context),
    );
  }

  Widget _buildDefaultErrorWidget(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.all(8),
      color: Colors.black12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off_rounded, color: Colors.orangeAccent, size: 32),
          const SizedBox(height: 4),
          Text(
            widget.countryName != null && widget.countryName!.isNotEmpty
                ? widget.countryName!
                : 'Offline Ready',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 2),
          const Text(
            'Connect internet to sync flags',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
