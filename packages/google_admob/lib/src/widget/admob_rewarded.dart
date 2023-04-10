import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobRewardedController {
  RewardedAd? _rewardedInterstitialAd;
  final String adUnitId;
  final void Function(
    AdWithoutView adWithoutView,
    RewardItem rewardItem,
  ) onUserEarnedReward;

  AdmobRewardedController({
    required this.adUnitId,
    required this.onUserEarnedReward,
  });

  void loadAd({bool showImmediately = false}) {
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            // Called when the ad showed the full screen content.
            onAdShowedFullScreenContent: (ad) {
              debugPrint('onAdShowedFullScreenContent $ad');
            },
            // Called when an impression occurs on the ad.
            onAdImpression: (ad) {
              debugPrint('onAdImpression $ad');
            },
            // Called when the ad failed to show full screen content.
            onAdFailedToShowFullScreenContent: (ad, err) {
              // Dispose the ad here to free resources.
              debugPrint('onAdFailedToShowFullScreenContent $err');
              ad.dispose();
            },
            // Called when the ad dismissed full screen content.
            onAdDismissedFullScreenContent: (ad) {
              // Dispose the ad here to free resources.
              debugPrint('onAdDismissedFullScreenContent $ad');
            },
            // Called when a click is recorded for an ad.
            onAdClicked: (ad) {
              debugPrint('onAdClicked $ad');
            },
          );

          if (showImmediately) {
            show();
          }

          debugPrint('$ad loaded.');
          // Keep a reference to the ad so you can show it later.
          _rewardedInterstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          debugPrint('RewardedInterstitialAd failed to load: $error');
        },
      ),
    );
  }

  Future<String?> show() async {
    try {
      if (_rewardedInterstitialAd != null) {
        await _rewardedInterstitialAd?.show(
          onUserEarnedReward: onUserEarnedReward,
        );
        return null;
      } else {
        return 'Please wait, we are preparing the ad';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> dispose() async => _rewardedInterstitialAd?.dispose();
}
