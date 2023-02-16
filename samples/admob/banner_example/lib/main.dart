import 'dart:io';

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
  List<BannerAd?> _bannerAds = List.empty(growable: true);
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
              if (_bannerAds[10] != null)
                SizedBox(
                  width: _bannerAds[10]!.size.width.toDouble(),
                  height: _bannerAds[10]!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAds[10]!),
                ),
              if (_bannerAds[11] != null)
                SizedBox(
                  width: _bannerAds[11]!.size.width.toDouble(),
                  height: _bannerAds[11]!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAds[11]!),
                ),
              if (_bannerAds[12] != null)
                SizedBox(
                  width: _bannerAds[12]!.size.width.toDouble(),
                  height: _bannerAds[12]!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAds[12]!),
                ),
              if (_bannerAds[3] != null)
                SizedBox(
                  width: _bannerAds[13]!.size.width.toDouble(),
                  height: _bannerAds[13]!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAds[13]!),
                ),
              if (_bannerAds[14] != null)
                SizedBox(
                  width: _bannerAds[14]!.size.width.toDouble(),
                  height: _bannerAds[14]!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAds[14]!),
                ),
              if (_bannerAds[15] != null)
                SizedBox(
                  width: _bannerAds[15]!.size.width.toDouble(),
                  height: _bannerAds[15]!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAds[15]!),
                ),
              if (_bannerAds[16] != null)
                SizedBox(
                  width: _bannerAds[16]!.size.width.toDouble(),
                  height: _bannerAds[16]!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAds[16]!),
                ),
              if (_bannerAds[17] != null)
                SizedBox(
                  width: _bannerAds[17]!.size.width.toDouble(),
                  height: _bannerAds[17]!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAds[17]!),
                ),
              if (_bannerAds[18] != null)
                SizedBox(
                  width: _bannerAds[18]!.size.width.toDouble(),
                  height: _bannerAds[18]!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAds[18]!),
                ),
              if (_bannerAds[19] != null)
                SizedBox(
                  width: _bannerAds[19]!.size.width.toDouble(),
                  height: _bannerAds[19]!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAds[19]!),
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
    _controller.dispose();
    super.dispose();
  }
}
