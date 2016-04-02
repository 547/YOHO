//
//  RequestWallPaper.h
//  YOHo
//
//  Created by mac on 16/4/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

/**请求壁纸*/
#import <Foundation/Foundation.h>
#import "DataModels.h"
#import <AFNetworking.h>
@interface RequestWallPaper : NSObject
+(void)getWallPapersSummerySuccess:(void(^)(NSArray *wallPapers))success;
@end
