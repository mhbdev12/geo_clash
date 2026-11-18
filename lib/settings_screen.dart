// ==========================================
// SETTINGS SCREEN - Themes, Sound, BGM & Sliders
// ==========================================
import 'package:flutter/material.dart';
import 'flag_data.dart';
import 'audio_manager.dart';
import 'ad_helper.dart'; // Import AdHelper for BottomBannerAdWidget
import 'flag_storage_service.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback onThemeChanged;

  const SettingsScreen({super.key, required this.onThemeChanged});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeColors.current;

    return Scaffold(
      backgroundColor: theme.bgEnd,
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: theme.cardBg,
        foregroundColor: theme.text,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // ==========================================
            // 1. THEME SELECTION SECTION
            // ==========================================
            Text('APPEARANCE & THEME', style: TextStyle(color: theme.primary, fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.border.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('App Theme Style', style: TextStyle(color: theme.text, fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      'Dark',
                      'Light',
                      'Neon Cyber',
                      'Sunset',
                    ].map((mode) {
                      bool isSelected = GameSettings.selectedTheme == mode;
                      return ChoiceChip(
                        label: Text(mode),
                        selected: isSelected,
                        selectedColor: theme.primary,
                        backgroundColor: theme.bgStart,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : theme.text,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              GameSettings.selectedTheme = mode;
                              ThemeColors.activeTheme = mode;
                            });
                            widget.onThemeChanged();
                          }
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ==========================================
            // 2. AUDIO & VOLUME CONTROL SECTION
            // ==========================================
            Text('AUDIO & VOLUME CONTROLS', style: TextStyle(color: theme.primary, fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 8),

            // --- SFX TOGGLE & SLIDER ---
            SwitchListTile(
              title: Text('Sound Effects (SFX)', style: TextStyle(color: theme.text, fontWeight: FontWeight.bold)),
              subtitle: Text('Play answer, combo & error sounds', style: TextStyle(color: theme.text.withValues(alpha: 0.6), fontSize: 12)),
              value: GameSettings.soundEffects,
              activeThumbColor: theme.primary,
              onChanged: (val) {
                setState(() => GameSettings.soundEffects = val);
              },
            ),

            if (GameSettings.soundEffects)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text('🔈', style: TextStyle(color: theme.text)),
                    Expanded(
                      child: Slider(
                        value: GameSettings.sfxVolume,
                        min: 0.0,
                        max: 1.0,
                        activeColor: theme.primary,
                        inactiveColor: theme.border,
                        onChanged: (val) {
                          setState(() {
                            AudioManager.updateSfxVolume(val);
                          });
                        },
                      ),
                    ),
                    Text('${(GameSettings.sfxVolume * 100).toInt()}%', style: TextStyle(color: theme.text, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

            const Divider(height: 20),

            // --- BGM TOGGLE & SLIDER ---
            SwitchListTile(
              title: Text('Background Music (BGM)', style: TextStyle(color: theme.text, fontWeight: FontWeight.bold)),
              subtitle: Text('Play subtle ambient music during gameplay', style: TextStyle(color: theme.text.withValues(alpha: 0.6), fontSize: 12)),
              value: GameSettings.bgmEnabled,
              activeThumbColor: theme.primary,
              onChanged: (val) {
                setState(() => GameSettings.bgmEnabled = val);
                AudioManager.toggleBgm(val);
              },
            ),

            if (GameSettings.bgmEnabled)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text('🎵', style: TextStyle(color: theme.text)),
                    Expanded(
                      child: Slider(
                        value: GameSettings.bgmVolume,
                        min: 0.0,
                        max: 1.0,
                        activeColor: theme.primary,
                        inactiveColor: theme.border,
                        onChanged: (val) {
                          setState(() {
                            AudioManager.updateBgmVolume(val);
                          });
                        },
                      ),
                    ),
                    Text('${(GameSettings.bgmVolume * 100).toInt()}%', style: TextStyle(color: theme.text, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

            const Divider(height: 20),

            // ==========================================
            // 3. VIBRATION SECTION
            // ==========================================
            SwitchListTile(
              title: Text('Screen Shake & Heavy Vibration', style: TextStyle(color: theme.text, fontWeight: FontWeight.bold)),
              subtitle: Text('Vibrate phone on "OH NO!" error responses', style: TextStyle(color: theme.text.withValues(alpha: 0.6), fontSize: 12)),
              value: GameSettings.enableShake,
              activeThumbColor: theme.primary,
              onChanged: (val) {
                setState(() => GameSettings.enableShake = val);
              },
            ),

            const Divider(height: 20),

            // ==========================================
            // 4. OFFLINE FLAG ASSETS & STORAGE
            // ==========================================
            Text('OFFLINE FLAG ASSETS & STORAGE', style: TextStyle(color: theme.primary, fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.border.withValues(alpha: 0.3)),
              ),
              child: ValueListenableBuilder<bool>(
                valueListenable: FlagStorageService.instance.isDownloading,
                builder: (context, isDownloading, child) {
                  return ValueListenableBuilder<int>(
                    valueListenable: FlagStorageService.instance.savedCount,
                    builder: (context, saved, child) {
                      return ValueListenableBuilder<double>(
                        valueListenable: FlagStorageService.instance.downloadProgress,
                        builder: (context, progress, child) {
                          final int total = FlagRepository.flags.length;
                          final bool isFullySaved = saved >= total;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    isFullySaved ? Icons.offline_pin_rounded : Icons.cloud_download_rounded,
                                    color: isFullySaved ? Colors.greenAccent : theme.primary,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          isFullySaved ? '100% Offline Ready' : 'Offline Flags Package',
                                          style: TextStyle(color: theme.text, fontWeight: FontWeight.bold, fontSize: 14),
                                        ),
                                        Text(
                                          '$saved of $total Flag & Map Images Saved Locally',
                                          style: TextStyle(color: theme.text.withValues(alpha: 0.6), fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (isDownloading) ...[
                                const SizedBox(height: 12),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: progress > 0 ? progress : null,
                                    color: theme.primary,
                                    backgroundColor: theme.bgStart,
                                    minHeight: 6,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Downloading for offline play... ${(progress * 100).toInt()}%',
                                  style: TextStyle(color: theme.text.withValues(alpha: 0.7), fontSize: 11),
                                ),
                              ],
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: isDownloading
                                      ? null
                                      : () {
                                          FlagStorageService.instance.preloadAllFlags(force: true);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Started saving all flags for offline play...'),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                  icon: Icon(
                                    isDownloading ? Icons.sync : Icons.download_rounded,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    isDownloading ? 'Syncing Flags...' : (isFullySaved ? 'Re-sync Flag Assets' : 'Download All Flags Now'),
                                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.primary,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // 📺 PINNED BOTTOM BANNER AD
      bottomNavigationBar: Container(
        color: theme.cardBg,
        child: const SafeArea(
          child: BottomBannerAdWidget(),
        ),
      ),
    );
  }
}