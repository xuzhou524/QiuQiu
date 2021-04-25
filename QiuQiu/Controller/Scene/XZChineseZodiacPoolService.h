//
//  XZChineseZodiacPoolService.h
//  QiuQiu
//
//  Created by xuzhou on 2021/4/14.
//

#import <Foundation/Foundation.h>

@class NormalChineseZodiacNode;
@class BombChineseZodiacNode;

@interface XZChineseZodiacPoolService : NSObject

+ (XZChineseZodiacPoolService *)sharedSingleton;
- (NormalChineseZodiacNode *)normalBubble;
- (BombChineseZodiacNode *)bombBubble;
- (void)releaseBubbleWithIndex:(NSInteger)index;

@end
