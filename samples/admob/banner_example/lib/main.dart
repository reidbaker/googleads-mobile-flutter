import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MaterialApp(
    home: BannerExample(),
  ));
}

/// A simple app that loads a banner ad.
class BannerExample extends StatefulWidget {
  const BannerExample({super.key});

  @override
  BannerExampleState createState() => BannerExampleState();
}

class BannerExampleState extends State<BannerExample> {
  List<BannerAd?> _bannerAds = List.empty(growable: true);
  final bannerSize = 10;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Banner Example',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Banner Example'),
          ),
          body: ListView(
            children: [
              const ListTile(
                title: Text('Some title'),
              ),
              const ListTile(
                title: Text('Some title'),
              ),
              const ListTile(
                title: Text('Some title'),
              ),
              const ListTile(
                title: Text('Some title'),
              ),
              const ListTile(
                title: Text('Some title'),
              ),
              const ListTile(
                title: Text('Some title'),
              ),
              const ListTile(
                title: Text('Some title'),
              ),
              const ListTile(
                title: Text('Some title'),
              ),
              const ListTile(
                title: Text('Some title'),
              ),
              const ListTile(
                title: Text('Some title'),
              ),
              const ListTile(
                title: Text('Some title'),
              ),
              if (_bannerAds[0] != null)
                SizedBox(
                  width: _bannerAds[0]!.size.width.toDouble(),
                  height: _bannerAds[0]!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAds[0]!),
                ),
              if (_bannerAds[1] != null)
                SizedBox(
                  width: _bannerAds[1]!.size.width.toDouble(),
                  height: _bannerAds[1]!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAds[1]!),
                ),
              if (_bannerAds[2] != null)
                SizedBox(
                  width: _bannerAds[2]!.size.width.toDouble(),
                  height: _bannerAds[2]!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAds[2]!),
                ),
              if (_bannerAds[3] != null)
                SizedBox(
                  width: _bannerAds[3]!.size.width.toDouble(),
                  height: _bannerAds[3]!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAds[3]!),
                ),
              if (_bannerAds[4] != null)
                SizedBox(
                  width: _bannerAds[4]!.size.width.toDouble(),
                  height: _bannerAds[4]!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAds[4]!),
                ),
              if (_bannerAds[5] != null)
                SizedBox(
                  width: _bannerAds[5]!.size.width.toDouble(),
                  height: _bannerAds[5]!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAds[5]!),
                ),
              if (_bannerAds[6] != null)
                SizedBox(
                  width: _bannerAds[6]!.size.width.toDouble(),
                  height: _bannerAds[6]!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAds[6]!),
                ),
              if (_bannerAds[7] != null)
                SizedBox(
                  width: _bannerAds[7]!.size.width.toDouble(),
                  height: _bannerAds[7]!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAds[7]!),
                ),
              if (_bannerAds[8] != null)
                SizedBox(
                  width: _bannerAds[8]!.size.width.toDouble(),
                  height: _bannerAds[8]!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAds[8]!),
                ),
              if (_bannerAds[9] != null)
                SizedBox(
                  width: _bannerAds[9]!.size.width.toDouble(),
                  height: _bannerAds[9]!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAds[9]!),
                ),
              const ListTile(
                title: Text('Some title'),
              ),
              const ListTile(
                title: Text('Some title'),
              ),
              const ListTile(
                title: Text('Some title'),
              ),
              const ListTile(
                title: Text('Some title'),
              ),
              const ListTile(
                title: Text('Some title'),
              ),
              const ListTile(
                title: Text('Some title'),
              ),
              const ListTile(
                title: Text('Some title'),
              ),
            ],
          ),
        ));
  }

  /// Loads and shows a banner ad.
  ///
  /// Dimensions of the ad are determined by the AdSize class.
  void _loadAd() async {
    for (var i = 0; i < bannerSize; i++) {
      BannerAd(
        adUnitId: _adUnitId,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            setState(() {
              _bannerAds.add(ad as BannerAd);
            });
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (ad, err) {
            ad.dispose();
          },
          // Called when an ad opens an overlay that covers the screen.
          onAdOpened: (Ad ad) {},
          // Called when an ad removes an overlay that covers the screen.
          onAdClosed: (Ad ad) {},
          // Called when an impression occurs on the ad.
          onAdImpression: (Ad ad) {},
        ),
      ).load();
    }
  }

  @override
  void dispose() {
    for (var i = 0; i < _bannerAds.length; i++) {
      _bannerAds[i]?.dispose();
    }
    super.dispose();
  }
}
