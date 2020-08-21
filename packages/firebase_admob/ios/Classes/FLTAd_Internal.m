#import "FLTAd_Internal.h"

@implementation FLTAdSize
- (instancetype _Nonnull)initWithWidth:(NSNumber *_Nonnull)width height:(NSNumber *_Nonnull)height {
  self = [super init];
  if (self) {
    _width = width;
    _height = height;

    // These values must remain consistent with `AdSize.smartBannerPortrait` and
    // `dSize.smartBannerLandscape` in Dart.
    if ([_width isEqual:@(-1)] && [_height isEqual:@(-2)]) {
      _size = kGADAdSizeSmartBannerPortrait;
    } else if ([_width isEqual:@(-1)] && [_height isEqual:@(-3)]) {
      _size = kGADAdSizeSmartBannerLandscape;
    } else {
      _size = GADAdSizeFromCGSize(CGSizeMake(width.doubleValue, height.doubleValue));
    }
  }
  return self;
}
@end

@implementation FLTAdRequest
- (GADRequest *_Nonnull)asGADRequest {
  GADRequest *request = [GADRequest request];
  request.keywords = _keywords;
  request.contentURL = _contentURL;
  request.birthday = _birthday;
  request.gender = _gender;
  [request tagForChildDirectedTreatment:_childDirected];
  request.testDevices = _testDevices;
  if (_nonPersonalizedAds) {
    GADExtras *extras = [[GADExtras alloc] init];
    extras.additionalParameters = @{@"npa" : @"1"};
    [request registerAdNetworkExtras:extras];
  }

  request.requestAgent = @"Flutter";
  return request;
}
@end

@implementation FLTNewBannerAd {
  GADBannerView *_bannerView;
  FLTAdRequest *_adRequest;
}

- (instancetype)initWithAdUnitId:(NSString *_Nonnull)adUnitId
                            size:(FLTAdSize *_Nonnull)size
                         request:(FLTAdRequest *_Nonnull)request
              rootViewController:(UIViewController *_Nonnull)rootViewController {
  self = [super init];
  if (self) {
    _adRequest = request;
    _bannerView = [[GADBannerView alloc] initWithAdSize:size.size];
    _bannerView.adUnitID = adUnitId;
    _bannerView.rootViewController = rootViewController;
  }
  return self;
}

- (void)load {
  _bannerView.delegate = self;
  [_bannerView loadRequest:[_adRequest asGADRequest]];
}

- (void)adView:(GADBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error {
  [_manager onAdFailedToLoad:self];
}

- (void)adViewWillPresentScreen:(GADBannerView *)adView {
  [_manager onAdOpened:self];
}

- (void)adViewDidDismissScreen:(GADBannerView *)adView {
  [_manager onAdClosed:self];
}

- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
  [_manager onApplicationExit:self];
}

- (void)adViewDidReceiveAd:(GADBannerView *)adView {
  [_manager onAdLoaded:self];
}

- (nonnull UIView *)view {
  return _bannerView;
}
@end

@implementation FLTNewInterstitialAd {
  GADInterstitial *_interstitialView;
  FLTAdRequest *_adRequest;
  UIViewController *_rootViewController;
}

- (instancetype)initWithAdUnitId:(NSString *_Nonnull)adUnitId
                         request:(FLTAdRequest *_Nonnull)request
              rootViewController:(UIViewController *_Nonnull)rootViewController {
  self = [super init];
  if (self) {
    _adRequest = request;
    _interstitialView = [[GADInterstitial alloc] initWithAdUnitID:adUnitId];
    _interstitialView.delegate = self;
    _rootViewController = rootViewController;
  }
  return self;
}

- (void)load {
  [_interstitialView loadRequest:[_adRequest asGADRequest]];
}

- (void)show {
  if (_interstitialView.isReady) {
    [_interstitialView presentFromRootViewController:_rootViewController];
  } else {
    NSLog(@"InterstitialAd failed to show because the ad was not ready.");
  }
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
  [_manager onAdLoaded:self];
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
  [_manager onAdFailedToLoad:self];
}

- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
  [_manager onAdOpened:self];
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
  [_manager onAdClosed:self];
}

- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
  [_manager onApplicationExit:self];
}
@end

@implementation FLTNewRewardedAd {
  GADRewardedAd *_rewardedView;
  FLTAdRequest *_adRequest;
  UIViewController *_rootViewController;
}

- (instancetype)initWithAdUnitId:(NSString *_Nonnull)adUnitId
                         request:(FLTAdRequest *_Nonnull)request
              rootViewController:(UIViewController *_Nonnull)rootViewController {
  self = [super init];
  if (self) {
    _adRequest = request;
    _rewardedView = [[GADRewardedAd alloc] initWithAdUnitID:adUnitId];
    _rootViewController = rootViewController;
  }
  return self;
}

- (void)load {
  [_rewardedView loadRequest:[_adRequest asGADRequest]
           completionHandler:^(GADRequestError *_Nullable error) {
             if (error) {
               [self->_manager onAdFailedToLoad:self];
             } else {
               [self->_manager onAdLoaded:self];
             }
           }];
}

- (void)show {
  if (_rewardedView.isReady) {
    [_rewardedView presentFromRootViewController:_rootViewController delegate:self];
  } else {
    NSLog(@"RewardedAd failed to show because the ad was not ready.");
  }
}

- (void)rewardedAd:(nonnull GADRewardedAd *)rewardedAd
    userDidEarnReward:(nonnull GADAdReward *)reward {
  [_manager onRewardedAdUserEarnedReward:self
                                  reward:[[FLTRewardItem alloc] initWithAmount:reward.amount
                                                                          type:reward.type]];
}

- (void)rewardedAdDidPresent:(GADRewardedAd *)rewardedAd {
  [_manager onAdOpened:self];
}

- (void)rewardedAdDidDismiss:(GADRewardedAd *)rewardedAd {
  [_manager onAdClosed:self];
}
@end

@implementation FLTNewNativeAd {
  NSString *_adUnitId;
  NSObject<FLTNativeAdFactory> *_nativeAdFactory;
  NSDictionary<NSString *, id> *_customOptions;
  GADUnifiedNativeAdView *_view;
  GADAdLoader *_adLoader;
}

- (instancetype _Nonnull)initWithAdUnitId:(NSString *_Nonnull)adUnitId
                                  request:(FLTAdRequest *_Nonnull)request
                          nativeAdFactory:(NSObject<FLTNativeAdFactory> *_Nonnull)nativeAdFactory
                            customOptions:(NSDictionary<NSString *, id> *_Nullable)customOptions
                       rootViewController:(UIViewController *_Nonnull)rootViewController {
  self = [super init];
  if (self) {
    _adUnitId = adUnitId;
    _nativeAdFactory = nativeAdFactory;
    _customOptions = customOptions;
    _adLoader = [[GADAdLoader alloc] initWithAdUnitID:_adUnitId
                                   rootViewController:rootViewController
                                              adTypes:@[ kGADAdLoaderAdTypeUnifiedNative ]
                                              options:@[]];
    _adLoader.delegate = self;
  }
  return self;
}

- (void)load {
  [_adLoader loadRequest:[GADRequest request]];
}

- (void)adLoader:(GADAdLoader *)adLoader didReceiveUnifiedNativeAd:(GADUnifiedNativeAd *)nativeAd {
  _view = [_nativeAdFactory createNativeAd:nativeAd customOptions:_customOptions];
  nativeAd.delegate = self;
  [_manager onAdLoaded:self];
}

- (void)adLoader:(GADAdLoader *)adLoader didFailToReceiveAdWithError:(GADRequestError *)error {
  [_manager onAdFailedToLoad:self];
}

- (void)nativeAdDidRecordClick:(GADUnifiedNativeAd *)nativeAd {
  [_manager onNativeAdClicked:self];
}

- (void)nativeAdDidRecordImpression:(GADUnifiedNativeAd *)nativeAd {
  [_manager onNativeAdImpression:self];
}

- (void)nativeAdWillPresentScreen:(GADUnifiedNativeAd *)nativeAd {
  [_manager onAdOpened:self];
}

- (void)nativeAdWillLeaveApplication:(GADUnifiedNativeAd *)nativeAd {
  [_manager onApplicationExit:self];
}

- (void)nativeAdDidDismissScreen:(GADUnifiedNativeAd *)nativeAd {
  [_manager onAdClosed:self];
}

- (UIView *)view {
  return _view;
}
@end

@implementation FLTRewardItem
- (instancetype _Nonnull)initWithAmount:(NSNumber *_Nonnull)amount type:(NSString *_Nonnull)type {
  self = [super init];
  if (self) {
    _amount = amount;
    _type = type;
  }
  return self;
}

- (BOOL)isEqual:(id)other {
  if (other == self) {
    return YES;
  } else if (![super isEqual:other]) {
    return NO;
  } else {
    FLTRewardItem *item = other;
    return [_amount isEqual:item.amount] && [_type isEqual:item.type];
  }
}

- (NSUInteger)hash {
  return _amount.hash | _type.hash;
}
@end