//
//  RequestVideo.m
//  YOHo
//
//  Created by mac on 16/4/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "RequestVideo.h"

@implementation RequestVideo


+(void)requestVideoBannersWithChannelId:(NSString *)channelId Success:(void(^)(NSDictionary *responseDic))success
{

    NSString *urlString = [NSString stringWithFormat:@"http://new.yohoboys.com/yohoboyins/v4/channel/banner?parameters={\"channelId\":\"%@\",\"language\":\"zh-Hans\"}",channelId];
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

/**获取ContentVideoBanners*/
+(void)getVideoBannersWithChannelId:(NSString *)channelId Success:(void(^)(NSArray *videoBanners))success
{
    NSLog(@"channelId====%@",channelId);
    [RequestVideo requestVideoBannersWithChannelId:channelId Success:^(NSDictionary *responseDic) {
        BannerInfo *banner = [BannerInfo modelObjectWithDictionary:responseDic];
        
        
        success(banner.data);
    }];
}



+(void)requestVideoSummeryWithChannelId:(NSString *)channelId Success:(void(^)(NSDictionary *responseDic))success
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://new.yohoboys.com/yohoboyins/v4/channel/contentList?parameters={\"channelId\":\"%@\",\"language\":\"zh-Hans\"}",channelId];
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


/**获取ContentVideoSummery*/
+(void)getVideoSummeryWithChannelId:(NSString *)channelId Success:(void(^)(NSArray *videoSummeries))success
{
     NSLog(@"channelId====%@",channelId);
    [RequestVideo requestVideoSummeryWithChannelId:channelId Success:^(NSDictionary *responseDic) {
        VideoSum *videoSummery = [VideoSum modelObjectWithDictionary:responseDic];
        success(videoSummery.data.content);
    }];
}


@end
