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
+(void)downImage:(NSString *)urlString;
@property(nonatomic,unsafe_unretained)id<EasyDownloadToolDelegate>delegate;
@end
@protocol EasyDownloadToolDelegate <NSObject>

-(void)easyDownloadProgress:(NSProgress *)progress;
-(void)easyDownloadFinsh;

@end