//
//  RequestRecommend.m
//  YOHo
//
//  Created by mac on 16/4/8.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "RequestRecommend.h"

@implementation RequestRecommend
//http://new.yohoboys.com/yohoboyins/v4/channel/getRelatedPosts?parameters={"language":"zh-Hans","num":3,"app":2,"curVersion":"4.0.3","cid":4169}

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
/**获取RecommendSum*/
+(void)getRecommendSumWithCIdOrLink:(NSString *)cId Success:(void(^)(RecommendSum *contentDetail))success
{
    NSLog(@"=000=======%@",cId);
    
    [RequestRecommend requestRecommendSumWithCIdOrLink:cId Success:^(NSDictionary *responseDic) {
        NSLog(@"%@",responseDic);
        RecommendSum *recommend = [RecommendSum modelObjectWithDictionary:responseDic];
        
        success(recommend);
        
    }];
}



@end
