//
//  RequestSplashImage.m
//  YOHo
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "RequestSplashImage.h"
#import <AFNetworking.h>
@implementation RequestSplashImage
{
    NSString *picStr;
}
+(void)getSplashImageDataSuccess:(void(^)(NSDictionary *responseDic))success
{

    NSString *urlString = @"http://new.yohoboys.com/yohoboyins/v4/common/getSplashScreen";
    
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
/**获取图片*/
+(void)getSplashImageSuccess:(void(^)(NSString *picUrl))success
{
    [RequestSplashImage getSplashImageDataSuccess:^(NSDictionary *responseDic) {
//        NSLog(@"444=====%@",responseDic);
        
        NSDictionary *dataDic = [responseDic objectForKey:@"data"];
//        NSLog(@"dataDic===%@",dataDic);
        NSString *picUrl = [dataDic objectForKey:@"pic"];
//        NSLog(@"version===%@",picUrl);
        success(picUrl);
        }];
}



@end
