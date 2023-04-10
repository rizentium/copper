import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdmobInterstitialController {
  InterstitialAd? _interstitialAd;
  final String adUnitId;

  AdmobInterstitialController({required this.adUnitId});

  void loadAd({bool showImmediately = false, int delayInMinutes = 5}) {
    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            // Called when the ad showed the full screen content.
            onAdShowedFullScreenContent: (ad) {},
            // Called when an impression occurs on the ad.
            onAdImpression: (ad) {},
            // Called when the ad failed to show full screen content.
            onAdFailedToShowFullScreenContent: (ad, err) {
              // Dispose the ad here to free resources.
              ad.dispose();
            },
            // Called when the ad dismissed full screen content.
            onAdDismissedFullScreenContent: (ad) {
              // Dispose the ad here to free resources.
              ad.dispose();
            },
            // Called when a click is recorded for an ad.
            onAdClicked: (ad) {},
          );

          if (showImmediately) {
            _showImmediately(ad, delayInMinutes);
          }

          debugPrint('$ad loaded.');
          // Keep a reference to the ad so you can show it later.
          _interstitialAd = ad;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  Future<bool> show() async {
    if (_interstitialAd != null) {
      await _interstitialAd?.show();
      return true;
    } else {
      debugPrint('interstial ad is not loaded yet');
      return false;
    }
  }

  Future<void> _showImmediately(InterstitialAd ad, int delayInMinutes) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'LAST_ADS_IMMEDIATELY_SHOWN';
    final lastShown = prefs.getString(key);
    final currentTime = DateTime.now();

    Future<List<void>> showAds() => Future.wait([
          ad.show(),
          prefs.setString(key, currentTime.toIso8601String()),
        ]);

    if (lastShown == null) {
      await showAds();
      return;
    }

    final difference = currentTime.difference(DateTime.parse(lastShown));

    debugPrint(
      'interstitial ad should be shown in '
      '${delayInMinutes - difference.inMinutes} minute(s)',
    );

    if (delayInMinutes - difference.inMinutes <= 0) {
      await prefs.remove(key);
      debugPrint('difference just removed');
    }
  }
}
