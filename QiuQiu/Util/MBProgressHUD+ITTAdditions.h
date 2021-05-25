//
//  MBProgressHUD+ITTAdditions.h
//  JuWan
//
//  Created by gozap on 2021/3/29.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (ITTAdditions)
+ (void)showDefaultIndicatorWithText:(NSString *)text;
+ (void)hideDefaultIndicator;

+ (void)hideAllIndicator;
+ (void)showIndicatorMessage:(NSString *)message;
+ (void)showMultilineIndicatorMessage:(NSString *)message;
@end
