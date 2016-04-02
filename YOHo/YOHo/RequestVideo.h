//
//  RequestVideo.h
//  YOHo
//
//  Created by mac on 16/4/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "DataModels.h"
@interface RequestVideo : NSObject
/**获取ContentVideoBanners*/
+(void)getVideoBannersWithChannelId:(NSString *)channelId Success:(void(^)(NSArray *videoBanners))success;
+(void)getVideoSummeryWithChannelId:(NSString *)channelId Success:(void(^)(NSArray *videoSummeries))success;
@end
