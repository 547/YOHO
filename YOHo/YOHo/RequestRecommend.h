//
//  RequestRecommend.h
//  YOHo
//
//  Created by mac on 16/4/8.
//  Copyright © 2016年 Seven. All rights reserved.
//

/**请求相关推荐**/
#import <Foundation/Foundation.h>
#import "DataModels.h"
#import <AFNetworking.h>
@interface RequestRecommend : NSObject
/**获取RecommendSum*/
+(void)getRecommendSumWithCIdOrLink:(NSString *)cId Success:(void(^)(RecommendSum *contentDetail))success;
@end
