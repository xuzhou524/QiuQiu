//
//  XZGameScene.m
//  QiuQiu
//
//  Created by xuzhou on 2021/4/19.
//

#import "XZGameScene.h"
#import "XZChineseZodiacPoolService.h"
#import "LDTipAlertView.h"
#import "QiuQiu-Swift.h"
#import "BombChineseZodiacNode.h"

typedef NS_OPTIONS(NSInteger, NODE_CATEGORY) {
    NODE_BUBBLE = 0,
    NODE_BORDER,
};

@interface XZGameScene () <SKPhysicsContactDelegate, BombChineseZodiacNodeDelegate, NormalChineseZodiacNodeDelegate>

@property (nonatomic) CGFloat itemWidth;
@property (nonatomic) CGFloat itemSpeed;
@property (nonatomic) NSInteger itemCount;
@property (nonatomic, getter = isResultNodeDisplayed) BOOL resultNodeDisplayed;
@property (nonatomic, getter = isStopped) BOOL stopped;

@property (strong, nonatomic) SKNode *ballBackgroundNode;
@property (strong, nonatomic) SKLabelNode *scoreLabel;
@property (strong, nonatomic) SKSpriteNode *coverNode;
@property (strong, nonatomic) SKAction *playSoundBomb;

@end

@implementation XZGameScene

static const NSInteger ROAD_NUM = 4;   //每行最大的个数
static const NSInteger BUBBLE_SIZE = 70;  //气泡的大小
static const NSInteger ORIGIN_TIME = 6; //下落的速度
static const NSInteger MAX_SPEED = 3;

- (void)didMoveToView:(SKView *)view{
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;
    self.itemSpeed = 1;
    self.playSoundBomb = [SKAction playSoundFileNamed:@"BombSound.mp3" waitForCompletion:YES];

    [self createAction];
    
    [self addChildren];
}

- (void)addChildren{

    SKNode *backgroundNode = [SKSpriteNode spriteNodeWithImageNamed:@"Background"];
    backgroundNode.position = CGPointMake((self.scene.frame.size.width / 2.00), (self.scene.frame.size.height / 2.00));
    backgroundNode.zPosition = 10;
    backgroundNode.xScale = 1.5;
    backgroundNode.yScale = 1.5;
    
    self.ballBackgroundNode = [SKNode node];
    self.ballBackgroundNode.zPosition = 20;
    
    SKSpriteNode *borderNode = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(self.scene.size.width, 1)];
    borderNode.name = @"Border";
    borderNode.position = CGPointMake(CGRectGetMidX(self.scene.frame), 0);
    borderNode.zPosition = 30;
    borderNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:borderNode.size];
    borderNode.physicsBody.categoryBitMask = NODE_BORDER;
    borderNode.physicsBody.contactTestBitMask = NODE_BORDER | NODE_BUBBLE;
    borderNode.physicsBody.collisionBitMask = NODE_BORDER;
    
    self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
    self.scoreLabel.text = @"0";
    self.scoreLabel.fontColor = [SKColor whiteColor];
    self.scoreLabel.fontSize = 32;
    self.scoreLabel.position = CGPointMake(CGRectGetMidX(self.scene.frame), self.scene.frame.size.height - self.scoreLabel.frame.size.height - 50);
    self.scoreLabel.zPosition = 100;
    
    [self addChild:backgroundNode];
    [self addChild:self.ballBackgroundNode];
    [self addChild:borderNode];
    [self addChild:self.scoreLabel];
}

- (void)createChineseZodiacNode{
    int cellCount = (arc4random() % 2 + 1);
    if (self.itemCount > 120) {
        cellCount = (arc4random() % 4 + 1);
    }else if (self.itemCount > 50){
        cellCount = (arc4random() % 3 + 1);
    }
    
    for (NSInteger i = 0; i < cellCount; i++) {
        CGSize bubbleSize = CGSizeMake(BUBBLE_SIZE, BUBBLE_SIZE);
        self.itemWidth = self.scene.frame.size.width / cellCount;
        CGFloat offsetX = i * self.itemWidth + self.itemWidth / 2;
        ChineseZodiacNode *chineseZodiacNode = nil;
        if (arc4random() % 10 == 0) {
            BombChineseZodiacNode *bombChineseZodiacNode = [[XZChineseZodiacPoolService sharedSingleton] bombBubble];
            bombChineseZodiacNode.delegate = self;
            chineseZodiacNode = (ChineseZodiacNode *)bombChineseZodiacNode;
        } else {
            NormalChineseZodiacNode *normalChineseZodiacNode = [[XZChineseZodiacPoolService sharedSingleton] normalBubble];
            normalChineseZodiacNode.delegate = self;
            chineseZodiacNode = (ChineseZodiacNode *)normalChineseZodiacNode;
        }
        chineseZodiacNode.name = @"Bubble";
        chineseZodiacNode.size = bubbleSize;
        chineseZodiacNode.speed = self.itemSpeed;
        chineseZodiacNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:chineseZodiacNode.size];
        chineseZodiacNode.physicsBody.categoryBitMask = NODE_BUBBLE;
        chineseZodiacNode.physicsBody.contactTestBitMask = NODE_BORDER | NODE_BUBBLE;
        chineseZodiacNode.physicsBody.collisionBitMask = NODE_BUBBLE;
        chineseZodiacNode.position = CGPointMake(offsetX, self.scene.frame.size.height + bubbleSize.height / 2);
        SKAction *bubbleMoveAction = [SKAction moveToY:-bubbleSize.height / 2 duration:ORIGIN_TIME];
        __weak typeof(self) weakSelf = self;
        SKAction *bubbleRemoveAction = [SKAction runBlock:^{
            weakSelf.itemCount++;
            [weakSelf updateLevel];
            [chineseZodiacNode removeFromParent];
            [[XZChineseZodiacPoolService sharedSingleton] releaseBubbleWithIndex:chineseZodiacNode.poolIndex];
        }];
        [chineseZodiacNode runAction:[SKAction sequence:@[bubbleMoveAction, bubbleRemoveAction]]];
        [self.ballBackgroundNode addChild:chineseZodiacNode];
    }
}

- (void)createAction{
    CGFloat gap = self.scene.frame.size.width / ROAD_NUM;
    NSTimeInterval duration = gap / ((self.scene.frame.size.height + gap) / (ORIGIN_TIME / self.itemSpeed));
    __weak typeof(self) weakSelf = self;
    SKAction *createBubbleAction = [SKAction runBlock:^{
        [weakSelf createChineseZodiacNode];
    }];
    SKAction *waitAction = [SKAction waitForDuration:duration];
    SKAction *repeatAction = [SKAction runBlock:^{
        [weakSelf createAction];
    }];
    SKAction *sequence = [SKAction sequence:@[createBubbleAction, waitAction, repeatAction]];
    [self runAction:sequence];
}

- (void)updateLevel{
    CGFloat speed = 0.1 * self.itemCount / (ROAD_NUM * 20) + 1;
    if (speed < MAX_SPEED && speed - self.itemSpeed >= 0.1) {
        self.itemSpeed = speed;
        __weak typeof(self) weakSelf = self;
        [self.ballBackgroundNode enumerateChildNodesWithName:@"Bubble" usingBlock:^(SKNode *node, BOOL *stop) {
            node.speed = weakSelf.itemSpeed;
        }];
    }
}

- (void)gameOver{
    
    NSInteger score = self.scoreLabel.text.integerValue;
    [XZGameCenterService saveHighScoreWithScore:score];
    NSString * d = [NSString stringWithFormat:@"最高分 %ld", (long)score];
    LDTipAlertView * tipAlertView = [[LDTipAlertView alloc] initWithMessage:d
                                    buttonTitles:@[@"返回首页",@"再来一次"]];
    [tipAlertView show];
    __weak typeof(self) weakSelf = self;
    [tipAlertView setCancelBlock:^{
        [weakSelf.delegate mySceneDidFinish:weakSelf];
    }];
    
    [tipAlertView setDefiniteBlock:^{
        CGSize size = [UIScreen mainScreen].bounds.size;
        XZGameScene *gameScene = [[XZGameScene alloc] initWithSize:size];
        gameScene.scaleMode = SKSceneScaleModeAspectFill;
        [self.scene.view presentScene:gameScene];
    }];

}

- (void)stopGame{
    if (!self.coverNode) {
        self.coverNode = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:self.scene.size];
        self.coverNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        self.coverNode.zPosition = 200;
        [self addChild:self.coverNode];
    }
    if (!self.isStopped) {
        self.stopped = YES;
        [self removeAllActions];
        [self.ballBackgroundNode.children enumerateObjectsUsingBlock:^(SKNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeAllActions];
        }];
    }
}

- (void)bubbleWink:(ChineseZodiacNode *)ChineseZodiacNode completion:(void (^)(void))block{
    SKAction *fadeInAction = [SKAction fadeInWithDuration:0.1];
    SKAction *fadeOutAction = [SKAction fadeOutWithDuration:0.1];
    SKAction *waitAction = [SKAction waitForDuration:0.1];
    SKAction *sequenceAction = [SKAction sequence:@[fadeOutAction, waitAction, fadeInAction, waitAction]];
//    SKAction *repeatAction = [SKAction sequence:@[sequenceAction, sequenceAction, sequenceAction]];
    [ChineseZodiacNode runAction:sequenceAction completion:^{
        if (block) {
            block();
        }
    }];
}

- (void)resetScene{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - BombChineseZodiacNodeDelegate

- (void)bombChineseZodiacNodeClick:(BombChineseZodiacNode *)bombChineseZodiacNode{
    [self stopGame];
    [self runAction:self.playSoundBomb];
    __weak typeof(self) weakSelf = self;
    [self bubbleWink:bombChineseZodiacNode completion:^{
        [weakSelf gameOver];
    }];
}

#pragma mark - NormalChineseZodiacNodeDelegate

- (void)normalChineseZodiacNodeClick:(NormalChineseZodiacNode *)normalChineseZodiacNode{
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)(self.scoreLabel.text.integerValue + self.speed * 10)];
}

#pragma mark - ContractTest

- (void)didBeginContact:(SKPhysicsContact *)contact{
    ChineseZodiacNode *chineseZodiacNode = nil;
    if ([contact.bodyA.node.name isEqualToString:@"Bubble"] && [contact.bodyB.node.name isEqualToString:@"Border"]) {
        chineseZodiacNode = (ChineseZodiacNode *)contact.bodyA.node;
    } else if ([contact.bodyA.node.name isEqualToString:@"Border"] && [contact.bodyB.node.name isEqualToString:@"Bubble"]) {
        chineseZodiacNode = (ChineseZodiacNode *)contact.bodyB.node;
    }
    if (chineseZodiacNode && chineseZodiacNode.status == BUBBLE_STATUS_NORMAL && [chineseZodiacNode isMemberOfClass:[NormalChineseZodiacNode class]]) {
        [self stopGame];
        __weak typeof(self) weakSelf = self;
        [self bubbleWink:chineseZodiacNode completion:^{
            [weakSelf gameOver];
        }];
    }
}
@end
