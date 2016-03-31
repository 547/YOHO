//
//  EasyDownloadTool.m
//  YOHo
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "EasyDownloadTool.h"
#import <AFNetworking.h>
#import "NSString+More.h"
@implementation EasyDownloadTool
+(void)downImage:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *path = [NSString getToTmpWithFileName:@"splashImage.png"];
        NSURL *pathUrl = [NSURL fileURLWithPath:path];
        return pathUrl;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            NSLog(@"请求出错：%@",error);
        }
    }];
}
@end
