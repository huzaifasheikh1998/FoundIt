import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:foundit/Controller/ad_controller.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobHelper {
  // testbanner  // static String get bannerUnit => 'ca-app-pub-3940256099942544/6300978111';

  final adController = Get.put(AdController());
  // String getAdUnitId() {
  //   if (kReleaseMode) {
  //     // Production environment
  //     return Platform.isAndroid
  //         ? "ca-app-pub-1536068652894498/7697930803"
  //         : 'ca-app-pub-3940256099942544/9214589741';
  //     // : "ca-app-pub-1536068652894498/6531392631";
  //   } else {
  //     // Debug environment
  //     return Platform.isAndroid
  //         ? "ca-app-pub-1536068652894498/7697930803"
  //         : 'ca-app-pub-3940256099942544/9214589741';
  //     // : "ca-app-pub-1536068652894498/6531392631"; // Example for interstitial test ad
  //   }
  // }

  // InterstitialAd? interstitialAd;
  // BannerAd? bannerAd;
  int num_of_attempt_load = 0;

  static void initialization() {
    MobileAds.instance.initialize().then((InitializationStatus status) {
      print("Initialization complete: ${status.adapterStatuses}");
      status.adapterStatuses.forEach((key, value) {
        print(
            "Adapter: $key, Status: ${value.description}, Latency: ${value.latency}ms");
      });
    });
  }

  static BannerAd getBannerAd() {
    return BannerAd(
      size: AdSize.fullBanner,
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/9214589741'
          : 'ca-app-pub-3940256099942544/9214589741',
      // : "ca-app-pub-1536068652894498/6531392631",
      listener: BannerAdListener(
        onAdClosed: (Ad ad) {
          print("Ad Closed");
          ad.dispose();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print("Ad Failed to Load: $error");
          ad.dispose();
        },
        onAdLoaded: (Ad ad) {
          print('Ad Loaded');
        },
        onAdOpened: (Ad ad) {
          print('Ad Opened');
        },
      ),
      request: const AdRequest(),
    );
  }

  // Create interstitial ads
  // void createInterad() {
  //   print("Attempting to load interstitial ad...");
  //   InterstitialAd.load(
  //     adUnitId: getAdUnitId(),
  //     //test interstitial   // 'ca-app-pub-3940256099942544/1033173712',
  //     request: const AdRequest(),
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: (InterstitialAd ad) {
  //         interstitialAd = ad;
  //         num_of_attempt_load = 0;
  //         print("Interstitial Ad Loaded");
  //       },
  //       onAdFailedToLoad: (LoadAdError error) {
  //         num_of_attempt_load += 1;
  //         interstitialAd = null;
  //         print("Interstitial Ad Failed to Load: $error");
  //         if (num_of_attempt_load <= 5) {
  //           createInterad();
  //         }
  //       },
  //     ),
  //   );
  // }

  void createBannerAd() {
    print("Attempting to load banner ad...");

    adController.bannerAd = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/9214589741'
          : 'ca-app-pub-3940256099942544/9214589741', // Use your banner ad unit ID
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print("Banner Ad Loaded");
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print("Banner Ad Failed to Load: $error");
          ad.dispose();
        },
      ),
    )..load();
    adController.update();
  }
  // Show interstitial ads to user
  // void showInterad() {
  //   if (interstitialAd == null) {
  //     print("Interstitial Ad is not available");
  //     return;
  //   }
  //
  //   interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
  //     onAdShowedFullScreenContent: (InterstitialAd ad) {
  //       print("Ad Showed Fullscreen");
  //     },
  //     onAdDismissedFullScreenContent: (InterstitialAd ad) {
  //       print("Ad Dismissed");
  //       ad.dispose();
  //     },
  //     onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError aderror) {
  //       print('$ad OnAdFailed: $aderror');
  //       ad.dispose();
  //       createInterad();
  //     },
  //   );
  //
  //   interstitialAd!.show();
  //   interstitialAd = null;
  // }

  void loadBannerAd() {
    if (adController.bannerAd != null) {
      print("Banner Ad is already loaded");
      return;
    }

    adController.bannerAd = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/9214589741'
          : "ca-app-pub-1536068652894498/6531392631",
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print("Banner Ad Loaded");
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print("Banner Ad Failed to Load: $error");
          adController.bannerAd?.dispose();
          adController.bannerAd = null;
        },
      ),
    );
    adController.update();
    adController.bannerAd!.load();
    getBannerAd();
  }
}
