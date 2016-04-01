//
//  RequestBannerInfo.m
//  YOHo
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "RequestBannerInfo.h"
#import <AFNetworking.h>
#import "BannerClass.h"
#import "Data.h"
@implementation RequestBannerInfo
+(void)getBannerWithChannelId:(NSString *)channelId Success:(void(^)(NSDictionary *responseDic))success
{
    NSString *curVersion = VERSION;
    
    NSString *urlString = [NSString stringWithFormat:@"http://new.yohoboys.com/yohoboyins/v4/channel/banner?parameters={\"channelId\":\"%@\",\"curVersion\":\"%@\",\"language\":\"zh-Hans\"}",channelId,curVersion];
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
/**获取banner数组*/
+(void)getBannerLinkAndImageWithChannelId:(NSString *)channelId Success:(void(^)(NSMutableArray *bannerArray))success
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [RequestBannerInfo getBannerWithChannelId:channelId Success:^(NSDictionary *responseDic) {
//        NSLog(@"dic==%@",responseDic);
        NSArray *data = [responseDic objectForKey:@"data"];
//        NSLog(@"da===%@",data);
        for (NSDictionary *dic in data) {
            BannerClass *banner = [BannerClass createBannerWithDic:dic];
            [array addObject:banner];
        }
        for (BannerClass *ba in array) {
            NSLog(@"bbb===%@",ba.link);
        }
        success(array);

    }];
}
@end
