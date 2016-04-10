//
//  RequestCommendExpression.m
//  YOHo
//
//  Created by mac on 16/4/9.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "RequestCommendExpression.h"

@implementation RequestCommendExpression

//http://new.yohoboys.com/yohoboyins/v4/channel/uptExpression?parameters={"app":2,"isCancel":1,"curVersion":"4.0.3","uid":"16F57C61-B466-46C7-A37A-49D62F526B0C","exType":0,"cid":4169}

+(void)requestCommendExpressiontWithCid:(NSString *)cId app:(NSString *)app type:(NSString *)type Success:(void(^)(NSDictionary *responseDic))success
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://new.yohoboys.com/yohoboyins/v4/channel/uptExpression?parameters={\"app\":%@,\"curVersion\":\"4.0.3\",\"uid\":\"16F57C61-B466-46C7-A37A-49D62F526B0C\",\"exType\":%@,\"cid\":%@}",app,type,cId];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //如果服务器提供的是text/html的就要设置接受类型，否则会报错Request failed: unacceptable content-type: text/html"====这句话的意思是需要设置content-type的为text/html
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObject:@"text/html"];
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        success(dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求出错：%@",error);
    }];
}

/**提交表情*/
+(void)postCommendExpressiontWithCid:(NSString *)cId app:(NSString *)app type:(NSString *)type Success:(void(^)(BOOL success))success
{
    
    [RequestCommendExpression requestCommendExpressiontWithCid:(NSString *)cId app:(NSString *)app type:(NSString *)type Success:^(NSDictionary *responseDic) {
        NSLog(@"----%@",responseDic);
        NSString *ma = [responseDic objectForKey:@"message"];
        NSLog(@"ma===%@",ma);
        NSString *code = [responseDic objectForKey:@"code"];
        int co = [code intValue];
        NSLog(@"-commit---%@",code);
        if (co == 200000) {
            success(YES);
        }else{
            success(NO);
        }
    }];
}



+(void)requestCancelCommendExpressiontWithCid:(NSString *)cId app:(NSString *)app type:(NSString *)type Success:(void(^)(NSDictionary *responseDic))success
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://new.yohoboys.com/yohoboyins/v4/channel/uptExpression?parameters={\"app\":%@,\"isCancel\":1,\"curVersion\":\"4.0.3\",\"uid\":\"16F57C61-B466-46C7-A37A-49D62F526B0C\",\"exType\":%@,\"cid\":%@}",app,type,cId];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //如果服务器提供的是text/html的就要设置接受类型，否则会报错Request failed: unacceptable content-type: text/html"====这句话的意思是需要设置content-type的为text/html
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObject:@"text/html"];
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        success(dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求出错：%@",error);
    }];
}

/**取消表情*/
+(void)cancelCommendExpressiontWithCid:(NSString *)cId app:(NSString *)app type:(NSString *)type Success:(void(^)(BOOL success))success
{
    
    [RequestCommendExpression requestCancelCommendExpressiontWithCid:(NSString *)cId app:(NSString *)app type:(NSString *)type Success:^(NSDictionary *responseDic) {
        NSLog(@"cancel----%@",responseDic);
        NSString *ma = [responseDic objectForKey:@"message"];
        NSLog(@"ma=c==%@",ma);
        NSString *code = [responseDic objectForKey:@"code"];
        int co = [code intValue];
        NSLog(@"-cancel---%@",code);
        if (co == 200000) {
            success(YES);
        }else{
            success(NO);
        }
        
    }];
}


@end
