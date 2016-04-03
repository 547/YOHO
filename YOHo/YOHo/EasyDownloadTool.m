//
//  EasyDownloadTool.m
//  YOHo
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "EasyDownloadTool.h"

#import "NSString+More.h"




@implementation EasyDownloadTool
{
    NSURL *urlPath;
}
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


-(AFHTTPSessionManager *)downLoadManager
{
    if (!_downLoadManager) {
        _downLoadManager = [AFHTTPSessionManager manager];
    }
    return _downLoadManager;
}


/**开始下载*/
-(void)startDownLoadWithUrlString:(NSString *)urlString fileName:(NSString *)fileName
{
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __weak EasyDownloadTool *weakSelf = self;
   _downloadTask = [self.downLoadManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //
        [weakSelf.delegate easyDownloadProgress:downloadProgress];
       if (downloadProgress.fractionCompleted == 1.0) {
           NSLog(@"成功");
           [weakSelf.delegate easyDownloadFinsh];
       }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //
        urlPath = [NSURL fileURLWithPath:[NSString getToDocumentsWithFileName:fileName]];
        return urlPath;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //
        if (error) {
            NSLog(@"error+++%@",error);
        }else{
            NSLog(@"下载");
        }
    }];
    
}

/**暂停下载*/
-(void)pauseDownload
{

    [_downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        self.savedData = resumeData;
    }];
    
}

/**继续下载*/
-(void)continueDownLoad
{
    __weak EasyDownloadTool *weakSelf = self;
    self.downloadTask = [self.downLoadManager downloadTaskWithResumeData:self.savedData progress:^(NSProgress * _Nonnull downloadProgress) {
        [weakSelf.delegate easyDownloadProgress:downloadProgress];
        if (downloadProgress.fractionCompleted == 1.0) {
            NSLog(@"成功");
            [weakSelf.delegate easyDownloadFinsh];
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return urlPath;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error+++%@",error);
        }else{
            NSLog(@"正在下载");
        }
    }];
    
}
@end
