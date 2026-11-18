// ==========================================
// AUDIO MANAGER - Handles BGM & SFX Volume Control
// ==========================================
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'flag_data.dart';

class AudioManager {
  static final AudioPlayer _bgmPlayer = AudioPlayer();
  static final AudioPlayer _sfxPlayer = AudioPlayer();   // Dedicated for Correct, Wrong, Combo
  static final AudioPlayer _tickPlayer = AudioPlayer();  // Dedicated for Timer Ticks
  static bool isBgmPlaying = false;

  /// Play custom SFX audio files instantly without blocking race conditions
  static Future<void> playSfx(String soundType) async {
    if (!GameSettings.soundEffects) return;

    try {
      if (soundType == 'tick') {
        await _tickPlayer.setVolume(GameSettings.sfxVolume);
        await _tickPlayer.play(AssetSource('sounds/tick.mp3'));
        HapticFeedback.selectionClick();
        return;
      }

      // Play answer SFX instantly without blocking stop/seek calls
      await _sfxPlayer.setVolume(GameSettings.sfxVolume);

      if (soundType == 'correct') {
        await _sfxPlayer.play(AssetSource('sounds/correct.mp3'));
        HapticFeedback.mediumImpact();
      } else if (soundType == 'combo') {
        await _sfxPlayer.play(AssetSource('sounds/combo.mp3'));
        HapticFeedback.heavyImpact();
      } else if (soundType == 'wrong') {
        await _sfxPlayer.play(AssetSource('sounds/wrong.mp3'));
        HapticFeedback.heavyImpact();
        Future.delayed(const Duration(milliseconds: 200), () => HapticFeedback.vibrate());
      }
    } catch (_) {}
  }

  /// Immediately stop active timer ticks
  static Future<void> stopSfx() async {
    try {
      await _tickPlayer.stop();
    } catch (_) {}
  }

  /// Start background music on infinite loop
  static Future<void> startBgm() async {
    if (!GameSettings.bgmEnabled) {
      stopBgm();
      return;
    }

    try {
      await _bgmPlayer.setReleaseMode(ReleaseMode.loop);
      await _bgmPlayer.setVolume(GameSettings.bgmVolume);
      await _bgmPlayer.play(AssetSource('sounds/background.mp3'));
      isBgmPlaying = true;
    } catch (_) {
      isBgmPlaying = false;
    }
  }

  /// Pause BGM temporarily (useful during video ad playback)
  static Future<void> pauseBgm() async {
    try {
      await _bgmPlayer.pause();
      isBgmPlaying = false;
    } catch (_) {}
  }

  /// Resume BGM after ad or dialog closes
  static Future<void> resumeBgm() async {
    if (!GameSettings.bgmEnabled) return;
    try {
      await _bgmPlayer.resume();
      isBgmPlaying = true;
    } catch (_) {
      startBgm();
    }
  }

  /// Live update for BGM volume while music is actively playing
  static Future<void> updateBgmVolume(double volume) async {
    GameSettings.bgmVolume = volume;
    try {
      await _bgmPlayer.setVolume(volume);
    } catch (_) {}
  }

  /// Live update for SFX volume
  static void updateSfxVolume(double volume) {
    GameSettings.sfxVolume = volume;
  }

  /// Stop background music completely
  static Future<void> stopBgm() async {
    try {
      await _bgmPlayer.stop();
      isBgmPlaying = false;
    } catch (_) {}
  }

  /// Toggle BGM state live from Settings screen
  static Future<void> toggleBgm(bool enable) async {
    GameSettings.bgmEnabled = enable;
    if (enable) {
      startBgm();
    } else {
      stopBgm();
    }
  }
}