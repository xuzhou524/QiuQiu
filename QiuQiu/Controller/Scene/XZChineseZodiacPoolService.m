//
//  XZChineseZodiacPoolService.m
//  QiuQiu
//
//  Created by xuzhou on 2021/4/14.
//

#import "XZChineseZodiacPoolService.h"
#import "BombChineseZodiacNode.h"

@interface XZChineseZodiacPoolService ()

@property (strong, nonatomic) NSMutableArray *bubblePool;

@end

@implementation XZChineseZodiacPoolService

+ (XZChineseZodiacPoolService *)sharedSingleton
{
    static XZChineseZodiacPoolService *sharedSingleton;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        if (!sharedSingleton) {
            sharedSingleton = [[XZChineseZodiacPoolService alloc] init];
        }
    });
    return sharedSingleton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _bubblePool = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NormalChineseZodiacNode *)normalBubble
{
    return (NormalChineseZodiacNode *)[self bubbleWithType:BUBBLE_TYPE_NORMAL];
}

- (BombChineseZodiacNode *)bombBubble
{
    return (BombChineseZodiacNode *)[self bubbleWithType:BUBBLE_TYPE_BOMB];
}

- (ChineseZodiacNode *)bubbleWithType:(BUBBLE_TYPE)type
{
    __block ChineseZodiacNode *chineseZodiacNode = nil;
    [self.bubblePool enumerateObjectsUsingBlock:^(ChineseZodiacNode *bubbleItem, NSUInteger idx, BOOL *stop) {
        if (bubbleItem.type == type && bubbleItem.poolStatus == BUBBLE_POOL_STATUS_AVAILABLE) {
            chineseZodiacNode = bubbleItem;
            *stop = YES;
        }
    }];
    if (chineseZodiacNode) {
        chineseZodiacNode.poolStatus = BUBBLE_POOL_STATUS_UNAVAILABLE;
        chineseZodiacNode.status = BUBBLE_STATUS_NORMAL;
        return chineseZodiacNode;
    }
    if (type == BUBBLE_TYPE_BOMB) {
        BombChineseZodiacNode *bombChineseZodiacNode = [[BombChineseZodiacNode alloc] init];
        bombChineseZodiacNode.poolStatus = BUBBLE_POOL_STATUS_UNAVAILABLE;
        bombChineseZodiacNode.poolIndex = self.bubblePool.count;
        [self.bubblePool addObject:bombChineseZodiacNode];
        return bombChineseZodiacNode;
    }
    NormalChineseZodiacNode *normalChineseZodiacNode = [[NormalChineseZodiacNode alloc] init];
    normalChineseZodiacNode.poolStatus = BUBBLE_POOL_STATUS_UNAVAILABLE;
    normalChineseZodiacNode.poolIndex = self.bubblePool.count;
    [self.bubblePool addObject:normalChineseZodiacNode];
    return normalChineseZodiacNode;
}

- (void)releaseBubbleWithIndex:(NSInteger)index
{
    [self.bubblePool enumerateObjectsUsingBlock:^(ChineseZodiacNode *bubbleItem, NSUInteger idx, BOOL *stop) {
        if (bubbleItem.poolIndex == index) {
            bubbleItem.poolStatus = BUBBLE_POOL_STATUS_AVAILABLE;
            *stop = YES;
        }
    }];
}

@end
