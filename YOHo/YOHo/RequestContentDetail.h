//
//  RequestContentDetail.h
//  YOHo
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "XMLToJson.h"
#import "DataModels.h"
@interface RequestContentDetail : NSObject
+(void)getContentDetailWithCIdOrLink:(NSString *)cId Success:(void(^)(ContentENSObject *contentDetail))success;
/**获取ContentDetail==app2*/
+(void)getContentDetailWithCIdOrLinkForApp1:(NSString *)cId Success:(void(^)(ContentENSObject *detail))success;
/**获取表情*/
+(void)getExpressionWithCIdOrLink:(NSString *)cId app:(NSString *)app Success:(void(^)(CommentExpression *expre))success;
@end
