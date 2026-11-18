// ==========================================
// AD HELPER - Interstitial, Rewarded, App Open & Banner Ads
// ==========================================
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static InterstitialAd? _interstitialAd;
  static DateTime? _lastAdShownTime;
  static int _adsShownThisSession = 0;

  static RewardedAd? _rewardedAd;

  static AppOpenAd? _appOpenAd;
  static bool _isShowingAppOpenAd = false;
  static DateTime? _appOpenLoadTime;

  // --- APP OPEN ADS ---
  static void loadAppOpenAd({VoidCallback? onLoaded}) {
    AppOpenAd.load(
      adUnitId: 'ca-app-pub-8052607409788601/8123044279', // Real open add id
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _appOpenLoadTime = DateTime.now();
          if (onLoaded != null) {
            onLoaded();
          }
        },
        onAdFailedToLoad: (error) {
          _appOpenAd = null;
        },
      ),
    );
  }

  /// Show App Open ad on app launch or resume
  static void showAppOpenAdIfAvailable() {
    if (_isShowingAppOpenAd) return;

    // Check if ad is available and loaded within the last 4 hours
    if (_appOpenAd == null || !_isAdAvailable()) {
      loadAppOpenAd();
      return;
    }

    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAppOpenAd = true;
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAppOpenAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAppOpenAd(); // Preload next App Open ad
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _isShowingAppOpenAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAppOpenAd();
      },
    );

    _appOpenAd!.show();
  }

  /// App Open Ads expire after 4 hours according to Google policy
  static bool _isAdAvailable() {
    if (_appOpenLoadTime == null) return false;
    return DateTime.now().difference(_appOpenLoadTime!).inHours < 4;
  }

  // --- INTERSTITIAL ADS ---
  static void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-8052607409788601/5286669932', // real Id
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (error) => _interstitialAd = null,
      ),
    );
  }

  static void showInterstitialAd({required Function onAdClosed}) {
    if (_adsShownThisSession >= 3) {
      onAdClosed();
      return;
    }

    if (_lastAdShownTime != null) {
      final difference = DateTime.now().difference(_lastAdShownTime!).inMinutes;
      if (difference < 20) {
        onAdClosed();
        return;
      }
    }

    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _adsShownThisSession++;
          _lastAdShownTime = DateTime.now();
          loadInterstitialAd();
          onAdClosed();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          loadInterstitialAd();
          onAdClosed();
        },
      );
      _interstitialAd!.show();
      _interstitialAd = null;
    } else {
      loadInterstitialAd();
      onAdClosed();
    }
  }

  // --- REWARDED ADS ---
  static void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-8052607409788601/4375370951', //Real rewarded ad
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => _rewardedAd = ad,
        onAdFailedToLoad: (error) => _rewardedAd = null,
      ),
    );
  }

  static void showRewardedAd({required BuildContext context, required Function onUserEarnedReward}) {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          loadRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          loadRewardedAd();
        },
      );

      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          onUserEarnedReward();
        },
      );
      _rewardedAd = null;
    } else {
      loadRewardedAd();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ad is loading, please try again in a moment.')),
      );
    }
  }
}

// --- REUSABLE BOTTOM BANNER WIDGET ---
class BottomBannerAdWidget extends StatefulWidget {
  const BottomBannerAdWidget({super.key});

  @override
  State<BottomBannerAdWidget> createState() => _BottomBannerAdWidgetState();
}

class _BottomBannerAdWidgetState extends State<BottomBannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-8052607409788601/2651225742', // real banner id
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() => _isLoaded = true);
          }
        },
        onAdFailedToLoad: (ad, error) => ad.dispose(),
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded || _bannerAd == null) return const SizedBox.shrink();
    return Container(
      alignment: Alignment.center,
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}