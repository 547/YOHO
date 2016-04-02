//
//  RequestMagazine.h
//  YOHo
//
//  Created by mac on 16/4/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

/**请求杂志**/
#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "DataModels.h"
@interface RequestMagazine : NSObject
+(void)getMagazinesSummeryWithWithType:(NSString *)type Success:(void(^)(NSArray *magazines))success;
@end
