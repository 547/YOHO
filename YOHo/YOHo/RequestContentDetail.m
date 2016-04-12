//
//  RequestContentDetail.m
//  YOHo
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "RequestContentDetail.h"

@implementation RequestContentDetail
//http://new.yohoboys.com/yohoboyins/v4/channel/getContentDetail?parameters={"app":2,"language":"zh-Hans","cid":4169}

//http://new.yohoboys.com/yohoboyins/v4/channel/getExpression?parameters={"app":2,"curVersion":"4.0.3","uid":"16F57C61-B466-46C7-A37A-49D62F526B0C","cid":4187}
//http://new.yohoboys.com/yohoboyins/v4/channel/getContentDetail?parameters={"app":1,"id":0,"language":"zh-Hans","curVersion":"4.0.3","cid":9771}



+(void)getContentWithCIdOrLink:(NSString *)cId Success:(void(^)(NSDictionary *responseDic))success
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://new.yohoboys.com/yohoboyins/v4/channel/getContentDetail?parameters={\"app\":2,\"language\":\"zh-Hans\",\"cid\":%@}",cId];
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


/**获取ContentDetail*/
+(void)getContentDetailWithCIdOrLink:(NSString *)cId Success:(void(^)(ContentENSObject *contentDetail))success
{
//    NSLog(@"=000=======%@",cId);
    
    [RequestContentDetail getContentWithCIdOrLink:cId Success:^(NSDictionary *responseDic) {
        NSLog(@"%@",responseDic);
       ContentENSObject *contentDetail = [ContentENSObject modelObjectWithDictionary:responseDic];
        success(contentDetail);
    }];
    
}




#pragma mark===正文详情
+(void)getContentWithCIdOrLinkForApp1:(NSString *)cId Success:(void(^)(NSDictionary *responseDic))success
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://new.yohoboys.com/yohoboyins/v4/channel/getContentDetail?parameters={\"app\":1,\"language\":\"zh-Hans\",\"cid\":%@}",cId];
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


/**获取ContentDetail==app1*/
+(void)getContentDetailWithCIdOrLinkForApp1:(NSString *)cId Success:(void(^)(ContentENSObject *detail))success
{
    //    NSLog(@"=000=======%@",cId);
    
    [RequestContentDetail getContentWithCIdOrLinkForApp1:cId Success:^(NSDictionary *responseDic) {
        NSLog(@"%@",responseDic);
        ContentENSObject *contentDetail = [ContentENSObject modelObjectWithDictionary:responseDic];
        success(contentDetail);
    }];
    
}


#pragma mark===相关推荐

+(void)requestRecommendSumWithCIdOrLink:(NSString *)cId app:(NSString *)app Success:(void(^)(NSDictionary *responseDic))success
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://new.yohoboys.com/yohoboyins/v4/channel/getRelatedPosts?parameters={\"language\":\"zh-Hans\",\"num\":3,\"app\":%@,\"curVersion\":\"4.0.3\",\"cid\":%@}",app,cId];
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

/**获取相关推荐==*/
+(void)getRecommendSumWithCIdOrLink:(NSString *)cId app:(NSString *)app Success:(void(^)(RecommendSum *recommend))success
{
    
    
    
    [RequestContentDetail getRecommendSumWithCIdOrLink:cId app:app Success:^(RecommendSum *recommend) {
        success(recommend);
    }];
}

#pragma mark===表情评论
+(void)requestExpressionWithCIdOrLink:(NSString *)cId app:(NSString *)app Success:(void(^)(NSDictionary *responseDic))success
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://new.yohoboys.com/yohoboyins/v4/channel/getExpression?parameters={\"app\":%@,\"curVersion\":\"4.0.3\",\"uid\":\"16F57C61-B466-46C7-A37A-49D62F526B0C\",\"cid\":%@}",app,cId];
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


/**获取表情==app*/
+(void)getExpressionWithCIdOrLink:(NSString *)cId app:(NSString *)app Success:(void(^)(CommentExpression *expre))success
{
    //    NSLog(@"=000=======%@",cId);
    
    [RequestContentDetail requestExpressionWithCIdOrLink:(NSString *)cId app:(NSString *)app Success:^(NSDictionary *responseDic) {
        
        CommentExpression *expression = [CommentExpression modelObjectWithDictionary:responseDic];
       
        success(expression);
    }];
    
}



@end
