//
//  QiuQiuSwift.m
//  QiuQiu
//
//  Created by gozap on 2021/5/25.
//

#import "QiuQiuSwift.h"
#import "QiuQiu-Swift.h"
@import GoogleMobileAds;

@interface QiuQiuSwift()<GADFullScreenContentDelegate>

@property (nonatomic, strong) UIWindow* window;
@property (nonatomic, strong) UIViewController* adViewController;

@property(nonatomic, strong) GADInterstitialAd *interstitial;

@end

@implementation QiuQiuSwift

//在load 方法中，启动监听，可以做到无注入
+ (void)load{
    [self shareInstance];
}

+ (instancetype)shareInstance{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        #ifdef DEBUG
        #else
        if (![XZGameDecorateConfig restorePurchases]) {
            [self views];
        }
        #endif
    }
    return self;
}

-(void)views{
 
    ///如果是没啥经验的开发，请不要在初始化的代码里面做别的事，防止对主线程的卡顿，和 其他情况
    ///应用启动, 首次开屏广告
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        ///要等DidFinished方法结束后才能初始化UIWindow，不然会检测是否有rootViewController
        [self CheakAd];
    }];
    ///进入后台
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
    }];
  
}

-(void)CheakAd{//这一部分的逻辑大家根据自身需求定制
    //谷歌插屏广告
    GADRequest *request = [GADRequest request];
      [GADInterstitialAd loadWithAdUnitID:@"ca-app-pub-9353975206269682/8480943219"
                                      request:request
                            completionHandler:^(GADInterstitialAd *ad, NSError *error) {
          if (error) {
             NSLog(@"Failed to load interstitial ad with error: %@", [error localizedDescription]);
             return;
          }
          self.interstitial = ad;
          self.interstitial.fullScreenContentDelegate = self;
          [self.interstitial presentFromRootViewController:[UIApplication sharedApplication].windows.firstObject.rootViewController];
      }];
}

- (void)hide{
    [[UIApplication sharedApplication].windows.firstObject.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -GADInterstitialDelegate

- (void)ad:(nonnull id<GADFullScreenPresentingAd>)ad
didFailToPresentFullScreenContentWithError:(nonnull NSError *)error {
    NSLog(@"Ad did fail to present full screen content.");
}

- (void)adDidPresentFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(Timered:) userInfo:nil repeats:YES];
}

- (void)adDidDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    [self hide];
}

- (void)Timered:(NSTimer*)timer {
    [self hide];
}

@end
