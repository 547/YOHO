//
//  RequestSplashImage.h
//  YOHo
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 Seven. All rights reserved.
//
/**获取闪屏页的图片*/
#import <Foundation/Foundation.h>

@interface RequestSplashImage : NSObject
/**获取闪屏页的图片*/
+(void)getSplashImageSuccess:(void(^)(NSString *picUrl))success;

@end
