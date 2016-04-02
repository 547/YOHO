//
//  RequestWallPaper.m
//  YOHo
//
//  Created by mac on 16/4/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "RequestWallPaper.h"

@implementation RequestWallPaper
//http://h5api.myoho.net/index.php?r=Apiemag%2FGetWallpaperListV4

+(void)requestWallPapersSummerySuccess:(void(^)(NSDictionary *responseDic))success
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://h5api.myoho.net/index.php?r=Apiemag%%2FGetWallpaperListV4"];
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


/**获取MagazinesSummery*/
+(void)getWallPapersSummerySuccess:(void(^)(NSArray *wallPapers))success
{
    [RequestWallPaper requestWallPapersSummerySuccess:^(NSDictionary *responseDic) {
        WallPapersSum *sum = [WallPapersSum modelObjectWithDictionary:responseDic];
        success(sum.data.wallpaperList);
    }];
    
}

@end
