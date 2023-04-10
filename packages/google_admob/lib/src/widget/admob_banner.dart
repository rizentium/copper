import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobBanner extends StatefulWidget {
  final String adUnitId;
  final bool? showLoadingMessage;

  const AdmobBanner({
    super.key,
    required this.adUnitId,
    this.showLoadingMessage,
  });

  @override
  State<AdmobBanner> createState() => _AdmobBannerState();
}

class _AdmobBannerState extends State<AdmobBanner> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  _loadAd() {
    _bannerAd = BannerAd(
      adUnitId: widget.adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _isLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    if (_bannerAd != null && _isLoaded) {
      return SafeArea(
        child: SizedBox(
          height: _bannerAd?.size.height.toDouble(),
          width: _bannerAd?.size.width.toDouble(),
          child: AdWidget(ad: _bannerAd!),
        ),
      );
    }
    return SizedBox(
      height: _bannerAd?.size.height.toDouble(),
      width: _bannerAd?.size.width.toDouble(),
      child: ColoredBox(
        color: Colors.white,
        child: widget.showLoadingMessage == true
            ? const Center(
                child: Text('BannerAd loading...'),
              )
            : null,
      ),
    );
  }
}
