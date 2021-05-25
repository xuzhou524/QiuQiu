//
//  MBProgressHUD+ITTAdditions.m
//  JuWan
//
//  Created by gozap on 2021/3/29.
//

#import "MBProgressHUD+ITTAdditions.h"

@implementation MBProgressHUD (ITTAdditions)
+ (void)showDefaultIndicatorWithText:(NSString *)text {
    [MBProgressHUD hideDefaultIndicator];
    NSArray * array = [UIApplication sharedApplication].windows;
    UIWindow *keyWindow = array.firstObject;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.label.font = [UIFont systemFontOfSize:15];
    hud.label.text = text;
    hud.bezelView.blurEffectStyle = UIBlurEffectStyleLight;
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
    hud.label.textColor = [UIColor whiteColor];
    hud.userInteractionEnabled = NO;
}

+ (void)hideDefaultIndicator {
    NSArray * array = [UIApplication sharedApplication].windows;
    UIWindow *keyWindow = array.firstObject;
    [MBProgressHUD hideHUDForView:keyWindow animated:YES];
}


+ (void)hideAllIndicator {
    NSArray *ws = [[UIApplication sharedApplication] windows];
    for (UIWindow *w in ws) {
        [MBProgressHUD hideHUDForView:w animated:YES];
    }
}

+ (void)showIndicatorMessage:(NSString *)message {
    NSArray * array = [UIApplication sharedApplication].windows;
    UIWindow *keyWindow = array.firstObject;
    [MBProgressHUD hideHUDForView:keyWindow animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.font = [UIFont systemFontOfSize:15];
    hud.label.text = message;
    hud.bezelView.blurEffectStyle = UIBlurEffectStyleLight;
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
    hud.label.textColor = [UIColor whiteColor];
    hud.userInteractionEnabled = NO;
    [hud hideAnimated:YES afterDelay:2.0];
}

//多行
+ (void)showMultilineIndicatorMessage:(NSString *)message {
    NSArray * array = [UIApplication sharedApplication].windows;
    UIWindow *keyWindow = array.firstObject;
    [MBProgressHUD hideHUDForView:keyWindow animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.font = [UIFont systemFontOfSize:15];
    hud.detailsLabel.text = message;
    hud.userInteractionEnabled = NO;
    hud.bezelView.blurEffectStyle = UIBlurEffectStyleLight;
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
    hud.detailsLabel.textColor = [UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:2.0];
}

@end
