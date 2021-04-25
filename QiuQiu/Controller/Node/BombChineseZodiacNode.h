//
//  BombChineseZodiacNode.h
//  QiuQiu
//
//  Created by xuzhou on 2021/4/18.
//

#import "ChineseZodiacNode.h"

@class BombChineseZodiacNode;
@class NormalChineseZodiacNode;

@protocol BombChineseZodiacNodeDelegate <NSObject>
- (void)bombChineseZodiacNodeClick:(BombChineseZodiacNode *)bombChineseZodiacNode;
@end

@interface BombChineseZodiacNode : ChineseZodiacNode
@property (nonatomic, assign) id<BombChineseZodiacNodeDelegate> delegate;
@end

@protocol NormalChineseZodiacNodeDelegate <NSObject>
- (void)normalChineseZodiacNodeClick:(NormalChineseZodiacNode *)normalChineseZodiacNode;
@end

@interface NormalChineseZodiacNode : ChineseZodiacNode
@property (nonatomic, assign) id<NormalChineseZodiacNodeDelegate> delegate;
@end
