//
//  ChineseZodiacNode.m
//  QiuQiu
//
//  Created by xuzhou on 2021/4/16.
//

#import "ChineseZodiacNode.h"
#import "QiuQiu-Swift.h"

@interface ChineseZodiacNode ()

@property (strong, nonatomic) SKSpriteNode *bubbleNormalNode;
@property (strong, nonatomic) SKSpriteNode *bubbleFlatNode;

@end

@implementation ChineseZodiacNode

- (instancetype)initWithNormalFile:(NSString *)normarlFile flatFile:(NSString *)flatFile
{

    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        self.bubbleNormalNode = [SKSpriteNode spriteNodeWithImageNamed:normarlFile];
        self.bubbleNormalNode.name = @"BubbleNormal";
        self.bubbleFlatNode = [SKSpriteNode spriteNodeWithImageNamed:flatFile];
        self.bubbleFlatNode.name = [NSString stringWithFormat:@"BubbleFlat_%ld",(long)[XZGameDecorateConfig getGameThemeChineseZodiacType]];
        [self addChild:self.bubbleFlatNode];
        [self addChild:self.bubbleNormalNode];
        self.status = BUBBLE_STATUS_NORMAL;
    }
    return self;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Must use initWithNormalFile:flatFile: instead." userInfo:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.status == BUBBLE_STATUS_FlAT) {
        return;
    }
    for (UITouch *touch in touches) {
        CGPoint touchLocation = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:touchLocation];
        if (node == self.bubbleNormalNode) {
            self.status = BUBBLE_STATUS_FlAT;
            [self onBubbleClick];
        }
    }
}

- (void)onBubbleClick{
    
}

- (void)setSize:(CGSize)size
{
    self.bubbleNormalNode.size = size;
    self.bubbleFlatNode.size = size;
    super.size = size;
}

- (void)setStatus:(BUBBLE_STATUS)status
{
    _status = status;
    if (self.status == BUBBLE_STATUS_NORMAL) {
        self.bubbleNormalNode.hidden = NO;
        self.bubbleFlatNode.hidden = NO;
    } else if (self.status == BUBBLE_STATUS_FlAT) {
        self.bubbleNormalNode.hidden = YES;
        self.bubbleFlatNode.hidden = YES;
    }
}

@end
