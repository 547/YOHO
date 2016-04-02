//
//  RequestContentInfo.m
//  YOHo
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "RequestContentInfo.h"
#import <AFNetworking.h>
#import "Data.h"
#import "ContentClass.h"
@implementation RequestContentInfo
+(void)getContentInfo
{
//http://new.yohoboys.com/yohoboyins/v4/channel/contentList?parameters={"curVersion":"4.0.3","channelId":"1-16","limit":12,"language":"zh-Hans","refreshType":1,"localNum":12,"lastTime":"1459146766","startTime":0,"ruleTime":"1459146766"}
    
    
}

+(void)getContentWithChannelId:(NSString *)channelId Success:(void(^)(NSDictionary *responseDic))success
{
    NSString *curVersion = VERSION;
    
    NSString *urlString = [NSString stringWithFormat:@"http://new.yohoboys.com/yohoboyins/v4/channel/contentList?parameters={\"curVersion\":\"%@\",\"channelId\":\"%@\",\"language\":\"zh-Hans\"}",curVersion,channelId];
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
/**获取Content数组*/
+(void)getContentinfoWithChannelId:(NSString *)channelId Success:(void(^)(NSMutableArray *contentArray))success
{
    NSLog(@"=000=======%@",channelId);
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [RequestContentInfo getContentWithChannelId:channelId Success:^(NSDictionary *responseDic) {
        //        NSLog(@"dic==%@",responseDic);
        NSDictionary *data = [responseDic objectForKey:@"data"];
        NSArray *content = [data objectForKey:@"content"];
        //        NSLog(@"da===%@",data);
        for (NSDictionary *dic in content) {
            ContentClass *content = [ContentClass createContentWithDic:dic];
            [array addObject:content];
        }
        for (ContentClass *co in array) {
            NSLog(@"bbb===%@",co.image);
        }
        success(array);
        
    }];
}


@end
