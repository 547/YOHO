//
//  RequestSearch.h
//  YOHo
//
//  Created by mac on 16/4/8.
//  Copyright © 2016年 Seven. All rights reserved.
//
/**搜索请求**/
#import <Foundation/Foundation.h>
#import "DataModels.h"
#import <AFNetworking.h>
@interface RequestSearch : NSObject
/**获取搜索简单列表*/
+(void)getSearchEasyListWithString:(NSString *)str Success:(void(^)(SearchFWResult *result))success;
/**获取搜索最终结果*/
+(void)getSearchResultWithString:(NSString *)str Success:(void(^)(SearchTWResult *result))success;
@end
