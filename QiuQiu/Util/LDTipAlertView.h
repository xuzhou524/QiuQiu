//
//  LDTipAlertView.h
//  QiuQiu
//
//  Created by xuzhou on 2021/3/16.
//

#import <UIKit/UIKit.h>


@class LDTipAlertView;

//确定
typedef void (^DefiniteBlock)(void);
//取消
typedef void (^CancelBlock)(void);

@interface LDTipAlertView : UIView{
    NSArray *btnTitleArr;/**< 按钮标题数组，传入两个即可 */
    NSString *contextStr;
}

@property (nonatomic, strong) UILabel *contextLabel;
@property (nonatomic,copy) DefiniteBlock DefiniteBlock;/**< 确定Block */
@property (nonatomic,copy) CancelBlock CancelBlock;/**< 取消Block */

-(void)dismissAnimation;

//普通弹出框
- (id)initWithMessage:(NSString *)message buttonTitles:(NSArray *)btnArr;
- (void)show;


//是否有弹出view
- (BOOL)isVisible;
@end
