//
//  EasyDownloadTool.h
//  YOHo
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 Seven. All rights reserved.
//
/**简单下载器*/
#import <Foundation/Foundation.h>
#import <AFNetworking.h>
@protocol EasyDownloadToolDelegate;
@interface EasyDownloadTool : NSObject
@property(nonatomic,strong)AFHTTPSessionManager *downLoadManager;
@property(nonatomic,strong)NSURLSessionDownloadTask *downloadTask;

@property(nonatomic,strong)NSData *savedData;
/**开始下载*/
-(void)startDownLoadWithUrlString:(NSString *)urlString fileName:(NSString *)fileName;
/**暂停下载*/
-(void)pauseDownload;
/**继续下载*/
-(void)continueDownLoad;
+(void)downImage:(NSString *)urlString;
@property(nonatomic,unsafe_unretained)id<EasyDownloadToolDelegate>delegate;
@end
@protocol EasyDownloadToolDelegate <NSObject>
-(void)easyDownloadResumeData:(NSData *)reData;
-(void)easyDownloadProgress:(NSProgress *)progress;
-(void)easyDownloadSavePath:(NSString *)path;

@end