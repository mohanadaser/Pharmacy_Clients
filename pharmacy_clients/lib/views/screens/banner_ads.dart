import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdsScreen extends StatefulWidget {
  const BannerAdsScreen({super.key});

  @override
  State<BannerAdsScreen> createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAdsScreen> {
  late BannerAd myBanner;
  bool isLoaded = false;
  void initBanner() {
    myBanner = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    myBanner.load();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 50, child: AdWidget(ad: myBanner));
  }
}
