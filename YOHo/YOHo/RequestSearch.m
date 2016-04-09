//
//  RequestSearch.m
//  YOHo
//
//  Created by mac on 16/4/8.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "RequestSearch.h"

@implementation RequestSearch
//1.1http://new.yohoboys.com/yohoboyins/v4/channel/searchSuggestion?parameters={"keyword":"这","curVersion":"4.0.3"}
//1.2http://new.yohoboys.com/yohoboyins/v4/channel/search?parameters={"keyword":"马德里艺术家Okuda","curVersion":"4.0.3","language":"zh-Hans"}
//2.0http://new.yohoboys.com/yohoboyins/v4/channel/search?parameters={"keyword":"这","curVersion":"4.0.3","language":"zh-Hans"}

+(void)requestSearchResultWithString:(NSString *)str Success:(void(^)(NSDictionary *responseDic))success
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://new.yohoboys.com/yohoboyins/v4/channel/search?parameters={\"keyword\":\"%@\",\"curVersion\":\"4.0.3\",\"language\":\"zh-Hans\"}",str];
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

/**获取搜索最终结果*/
+(void)getSearchResultWithString:(NSString *)str Success:(void(^)(SearchTWResult *result))success
{
    NSLog(@"=000=======%@",str);
    [RequestSearch requestSearchResultWithString:str Success:^(NSDictionary *responseDic) {
        NSLog(@"%@",responseDic);
        SearchTWResult *resu = [SearchTWResult modelObjectWithDictionary:responseDic];
        success(resu);
    }];
}


+(void)requestSearchEasyListWithString:(NSString *)str Success:(void(^)(NSDictionary *responseDic))success
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://new.yohoboys.com/yohoboyins/v4/channel/searchSuggestion?parameters={\"keyword\":\"%@\",\"curVersion\":\"4.0.3\"}",str];
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

/**获取搜索简单列表*/
+(void)getSearchEasyListWithString:(NSString *)str Success:(void(^)(SearchFWResult *result))success
{
    
    NSLog(@"=000=======%@",str);
    [RequestSearch requestSearchEasyListWithString:str Success:^(NSDictionary *responseDic) {
        NSLog(@"%@",responseDic);
        SearchFWResult *resu = [SearchFWResult modelObjectWithDictionary:responseDic];
        success(resu);
    }];
}


@end
