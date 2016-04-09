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

+(void)requestContentAndRecommendWithCidOrLink:(NSString *)cId
{

    //1.请求详情
    
    NSString *contentUrlString = [NSString stringWithFormat:@"http://new.yohoboys.com/yohoboyins/v4/channel/getContentDetail?parameters={\"app\":2,\"language\":\"zh-Hans\",\"cid\":%@}",cId];
    NSURLRequest *contentRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:contentUrlString]];
    

    
    
}


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

+(void)requestRecommendSumWithCIdOrLink:(NSString *)cId Success:(void(^)(NSDictionary *responseDic))success
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://new.yohoboys.com/yohoboyins/v4/channel/getRelatedPosts?parameters={\"language\":\"zh-Hans\",\"num\":3,\"app\":2,\"curVersion\":\"4.0.3\",\"cid\":%@}",cId];
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
    [RequestContentDetail requestRecommendSumWithCIdOrLink:cId Success:^(NSDictionary *responseDic) {
        //
    }];
}


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


/**获取ContentDetail==app2*/
+(void)getContentDetailWithCIdOrLinkForApp1:(NSString *)cId Success:(void(^)(ContentENSObject *detail))success
{
    //    NSLog(@"=000=======%@",cId);
    
    [RequestContentDetail getContentWithCIdOrLinkForApp1:cId Success:^(NSDictionary *responseDic) {
        NSLog(@"%@",responseDic);
        ContentENSObject *contentDetail = [ContentENSObject modelObjectWithDictionary:responseDic];
        success(contentDetail);
    }];
    
}

@end
