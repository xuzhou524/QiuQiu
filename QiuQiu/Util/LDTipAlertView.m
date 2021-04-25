//
//  LDTipAlertView.m
//  QiuQiu
//
//  Created by xuzhou on 2021/3/16.
//

#import "LDTipAlertView.h"
#import <QuartzCore/QuartzCore.h>

@interface LDTipAlertView(){
    CGSize alertSize;/**< Alert的尺寸 */
}
@property (nonatomic,strong) UIView *backgroundView;
@end

@implementation LDTipAlertView

- (id)initWithMessage:(NSString *)message buttonTitles:(NSArray *)btnArr{
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    if (self = [super initWithFrame:rect]){
        btnTitleArr = btnArr;
        self.backgroundColor = [UIColor clearColor];
        
        UIView *bgView = [[UIView alloc]initWithFrame:rect];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.6f;
        [self addSubview:bgView];
        
        contextStr = message;
        CGSize contextSize = [self measureSinglelineStringSize:message fontSize:15];
        alertSize = CGSizeMake(rect.size.width-45, 35 + contextSize.height + 35 + 40 + 20);
    }
    return self;
}

/**
 *  计算字符串的高度
 */
-(CGSize)measureSinglelineStringSize:(NSString*)str fontSize:(int)fontSize{
    if (str == nil) return CGSizeZero;
    
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    CGFloat width = rect.size.width-45-45;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = 8; //设置行间距
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paraStyle}];
    CGSize measureSize =  [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    
    return measureSize;
}

#pragma mark -创建组件
/**
 *  创建Alert体
 */
- (void)addBackgroundView{
    CGRect rect = CGRectMake(0, 0, alertSize.width, alertSize.height);

    _backgroundView = [[UIImageView alloc]init];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    _backgroundView.frame = rect;
    _backgroundView.userInteractionEnabled = YES;
    _backgroundView.layer.masksToBounds = YES;
    _backgroundView.layer.cornerRadius = 15;
    [self addSubview:_backgroundView];
    
    _backgroundView.center = self.center;
}

- (void)addAlertLabels{
    CGFloat width = alertSize.width-45;
    CGSize contextSize = [self measureSinglelineStringSize:contextStr fontSize:15];
    CGRect rect = CGRectMake((CGRectGetWidth(_backgroundView.frame)-width)/2, 35, width, contextSize.height);
    self.contextLabel = [[UILabel alloc]initWithFrame:rect];
    self.contextLabel.backgroundColor = [UIColor clearColor];
    self.contextLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.contextLabel.font = [UIFont systemFontOfSize:15];
    self.contextLabel.numberOfLines = 0;
    self.contextLabel.lineBreakMode = NSLineBreakByWordWrapping;

    if (contextSize.height <= 28) {
        self.contextLabel.textAlignment = NSTextAlignmentCenter;
    }else{
        self.contextLabel.textAlignment = NSTextAlignmentLeft;
    }
    self.contextLabel.text = contextStr;

    [_backgroundView addSubview:self.contextLabel];

    _backgroundView.center = self.center;
}

- (void)addAlertButtons{
    for (NSInteger i=0; i<btnTitleArr.count; i++){
        if(btnTitleArr.count == 2){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.layer.masksToBounds = YES;
            [btn setTitle:[btnTitleArr objectAtIndex:i] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            float offset = (CGRectGetWidth(_backgroundView.frame)-140*2)/3;
            btn.frame = CGRectMake(offset*(i+1)+140*i, CGRectGetHeight(_backgroundView.frame)-60, 140, 44);
            btn.layer.cornerRadius = 10;
            btn.layer.masksToBounds  = YES;
            btn.tag = i;
            if (i == 0){//拒绝按钮
                btn.layer.borderWidth  = 0.5;
                btn.layer.borderColor  = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0].CGColor;
                [btn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
            }else{//同意按钮
                [btn setBackgroundColor:[UIColor colorWithRed:74/255.0 green:78/255.0 blue:105/255.0 alpha:1.0]];
                [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
            }
            [_backgroundView addSubview:btn];
        }else if (btnTitleArr.count == 1){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:[btnTitleArr objectAtIndex:i] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

            btn.frame = CGRectMake(25, CGRectGetHeight(_backgroundView.frame)-60, CGRectGetWidth(_backgroundView.frame) - 50, 44);
            btn.tag = i;
      
            btn.layer.masksToBounds  = YES;
            btn.layer.cornerRadius = 10;
            [btn setBackgroundColor:[UIColor colorWithRed:74/255.0 green:78/255.0 blue:105/255.0 alpha:1.0]];
            [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];

            [_backgroundView addSubview:btn];
        }
    }
}

#pragma mark 点击按钮回调
- (void)buttonClick:(UIButton *)btnTag{
    if (btnTag.tag == 0) {//取消按钮
        if(self.CancelBlock){
            self.CancelBlock();
        }
    }else if (btnTag.tag == 1) {//确定按钮
        if(self.DefiniteBlock){
            self.DefiniteBlock();
        }
    }
    [self dismissAnimation];
}

#pragma mark -showWithAnimation
- (void)performAnimation{
    self.alpha = 0;
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{self.alpha = 1;}
                     completion:nil];
}

- (void)dismissAnimation{
    self.alpha = 1;
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{self.alpha = 0;}
                     completion:^(BOOL finish){[self removeFromSuperview];}];
}

#pragma mark -show
- (void)show{
    NSArray * array = [UIApplication sharedApplication].windows;
    UIWindow *alertWindow = array.firstObject;
    [self addBackgroundView];
    [self addAlertLabels];
    [self addAlertButtons];
    
    [alertWindow addSubview:self];
    [self performAnimation];
}

- (BOOL)isVisible{
    return (self.alpha > 0);
}

@end
