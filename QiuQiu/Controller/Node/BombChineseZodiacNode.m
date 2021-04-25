//
//  BombChineseZodiacNode.m
//  QiuQiu
//
//  Created by xuzhou on 2021/4/18.
//

#import "BombChineseZodiacNode.h"
#import "QiuQiu-Swift.h"

@interface BombChineseZodiacNode ()
@property (strong, nonatomic) SKAction *sequenceAction;
@end

@implementation BombChineseZodiacNode
- (instancetype)init{
    self = [super initWithNormalFile:@"BubbleBombNormal" flatFile:@"BubbleBombFlat"];
    if (self) {
        self.type = BUBBLE_TYPE_BOMB;
    }
    return self;
}

- (void)onBubbleClick{
    if ([self.delegate respondsToSelector:@selector(bombChineseZodiacNodeClick:)]) {
        [self.delegate bombChineseZodiacNodeClick:self];
    }
}
@end

@interface NormalChineseZodiacNode ()
@property (strong, nonatomic) SKAction *playSoundAction;
@end

@implementation NormalChineseZodiacNode
- (instancetype)init{
    self = [super initWithNormalFile:@"BubbleNormal" flatFile:[NSString stringWithFormat:@"BubbleFlat_%ld",(long)[XZGameDecorateConfig getGameThemeChineseZodiacType]]];
    if (self) {
        self.type = BUBBLE_TYPE_NORMAL;
        self.playSoundAction = [SKAction playSoundFileNamed:@"ChineseZodiacSound.mp3" waitForCompletion:NO];
    }
    return self;
}

- (void)onBubbleClick{
    [self runAction:self.playSoundAction];
    if ([self.delegate respondsToSelector:@selector(normalChineseZodiacNodeClick:)]) {
        [self.delegate normalChineseZodiacNodeClick:self];
    }
}
@end
