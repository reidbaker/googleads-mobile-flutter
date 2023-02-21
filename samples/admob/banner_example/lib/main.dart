import 'dart:io';

import 'package:banner_example/native-view-example.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:video_player/video_player.dart';

late VideoPlayerController _controller;
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
  final List<BannerAd?> _bannerAds = List.empty(growable: true);
  final bannerSize = 20;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  @override
  void initState() {
    super.initState();
    _loadAd();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final nativoAdView = NativeViewExample();
    return MaterialApp(
        title: 'Banner Example',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Banner Example'),
          ),
          floatingActionButton: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
          body: ListView(
            children: [
              const ListTile(
                title: Text('Some title'),
              ),
              Center(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : Container(),
              ),
              const ListTile(
                title: Text('Some title'),
              ),
              const ListTile(
                title: Text('Some title'),
              ),
              SizedBox(
                width: double.infinity,
                height: 400,
                child: nativoAdView,
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
              if (_bannerAds.isNotEmpty && _bannerAds[0] != null)
                createAd(0),
              if (_bannerAds.length > 1 && _bannerAds[1] != null)
                createAd(1),
              if (_bannerAds.length > 2 && _bannerAds[2] != null)
                createAd(2),
              if (_bannerAds.length > 3 && _bannerAds[3] != null)
                createAd(3),
              if (_bannerAds.length > 4 && _bannerAds[4] != null)
                createAd(4),
              if (_bannerAds.length > 5 && _bannerAds[5] != null)
                createAd(5),
              if (_bannerAds.length > 6 && _bannerAds[6] != null)
                createAd(6),
              if (_bannerAds.length > 7 && _bannerAds[7] != null)
                createAd(7),
              if (_bannerAds.length > 8 && _bannerAds[8] != null)
                createAd(8),
              if (_bannerAds.length > 9 && _bannerAds[9] != null)
                createAd(9),
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
              if (_bannerAds.length > 10 && _bannerAds[10] != null)
                createAd(10),
              if (_bannerAds.length > 11 && _bannerAds[11] != null)
                createAd(11),
              if (_bannerAds.length > 12 && _bannerAds[12] != null)
                createAd(12),
              if (_bannerAds.length > 13 && _bannerAds[13] != null)
                createAd(13),
              if (_bannerAds.length > 14 && _bannerAds[14] != null)
                createAd(14),
              if (_bannerAds.length > 15 && _bannerAds[15] != null)
                createAd(15),
              if (_bannerAds.length > 16 && _bannerAds[16] != null)
                createAd(16),
              if (_bannerAds.length > 17 && _bannerAds[17] != null)
                createAd(17),
              if (_bannerAds.length > 18 && _bannerAds[18] != null)
                createAd(18),
              if (_bannerAds.length > 19 && _bannerAds[19] != null)
                createAd(19),
            ],
          ),
        ));
  }

  SizedBox createAd(int index) {
    return SizedBox(
                width: _bannerAds[index]!.size.width.toDouble(),
                height: _bannerAds[index]!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAds[index]!),
              );
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
    _controller.dispose();
    super.dispose();
  }
}
