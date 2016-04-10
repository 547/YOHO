//
//  RequestCommendExpression.h
//  YOHo
//
//  Created by mac on 16/4/9.
//  Copyright © 2016年 Seven. All rights reserved.
//

/**提交表情，取消表情**/
#import <Foundation/Foundation.h>
#import <AFNetworking.h>
@interface RequestCommendExpression : NSObject
/**提交表情*/
+(void)postCommendExpressiontWithCid:(NSString *)cId app:(NSString *)app type:(NSString *)type Success:(void(^)(BOOL success))success;
/**取消表情*/
+(void)cancelCommendExpressiontWithCid:(NSString *)cId app:(NSString *)app type:(NSString *)type Success:(void(^)(BOOL success))success;
@end
