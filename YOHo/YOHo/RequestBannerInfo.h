//
//  RequestBannerInfo.h
//  YOHo
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 Seven. All rights reserved.
//
/**请求轮播的数据*/
#import <Foundation/Foundation.h>

@interface RequestBannerInfo : NSObject
+(void)getBannerLinkAndImageWithChannelId:(NSString *)channelId Success:(void(^)(NSMutableArray *bannerArray))success;
@end
