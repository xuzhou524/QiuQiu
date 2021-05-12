//
//  XZGameScene.h
//  QiuQiu
//
//  Created by xuzhou on 2021/4/19.
//

#import <SpriteKit/SpriteKit.h>
@protocol TCAMySceneDelegate;

@interface XZGameScene : SKScene

@property (nonatomic, weak) id<TCAMySceneDelegate> delegate;

@end


@protocol TCAMySceneDelegate <NSObject>
- (void)mySceneDidFinish;
@end
