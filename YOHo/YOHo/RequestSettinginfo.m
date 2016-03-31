//
//  RequestSettinginfo.m
//  YOHo
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "RequestSettinginfo.h"
#import "SaveToUserDefault.h"
#import <AFNetworking.h>
@implementation RequestSettinginfo
+(void)getSettingInfoSuccess:(void(^)(NSDictionary *responseDic))success
{
    
    NSString *urlString = @"http://new.yohoboys.com/yohoboyins/v4/setting/imageType";
    
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

+(void)saveSetting
{
    [RequestSettinginfo getSettingInfoSuccess:^(NSDictionary *responseDic) {
        NSLog(@"----%@",responseDic);
        NSDictionary *dataDic = [responseDic objectForKey:@"data"];
        NSLog(@"dataDic===%@",dataDic);
//        NSString *version = [dataDic objectForKey:@"version"];
//        NSLog(@"version===%@",version);
//        [SaveToUserDefault saveString:version key:@"version"];
    }];
}

@end
