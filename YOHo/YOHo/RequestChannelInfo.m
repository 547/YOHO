//
//  RequestChannelInfo.m
//  YOHo
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "RequestChannelInfo.h"
#import <AFNetworking.h>

@implementation RequestChannelInfo
+(void)getChannelInfoSuccess:(void(^)(NSDictionary *responseDic))success
{
    
    NSString *urlString = @"http://new.yohoboys.com/yohoboyins/v4/channel/navigation?parameters=%7B%22curVersion%22%3A%224.0.3%22%2C%22MagazineString%22%3A%22YOHO%21BOY%20135%22%2C%22WallpaperString%22%3A%22138%22%7D";
    
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

/**获取ChannelArray*/
+(void)getChannelArraySuccess:(void(^)(NSMutableDictionary *channelDic))success
{
    NSMutableDictionary *channelDic = [[NSMutableDictionary alloc]init];
    [RequestChannelInfo getChannelInfoSuccess:^(NSDictionary *responseDic) {
//        NSLog(@"ChannelInfo----%@",responseDic);
        NSArray *dataArray = [responseDic objectForKey:@"data"];
        for (NSDictionary *dic in dataArray) {
            NSString *superName = [dic objectForKey:@"channel_name_cn"];
            NSString *channelId = [dic objectForKey:@"id"];
            NSArray *subNav = [dic objectForKey:@"subNav"];
           NSMutableArray *channel_name_cnArray = [[NSMutableArray alloc]init];
           NSMutableArray *channel_name_enArray = [[NSMutableArray alloc]init];
            NSMutableArray *channel_name_idArray = [[NSMutableArray alloc]init];
            for (NSDictionary *dic in subNav) {
                NSString *channel_name_cn = [dic objectForKey:@"channel_name_cn"];
                NSString *channel_name_en = [dic objectForKey:@"channel_name_en"];
                NSString *channel_name_id = [dic objectForKey:@"id"];
                [channel_name_enArray addObject:channel_name_en];
                [channel_name_cnArray addObject:channel_name_cn];
                [channel_name_idArray addObject:channel_name_id];
            }
            [channelDic setObject:@[channel_name_cnArray,channel_name_enArray,channel_name_idArray,channelId] forKey:superName];

        }
        success(channelDic);
    }];
}

@end
