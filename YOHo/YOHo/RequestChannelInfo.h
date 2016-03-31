//
//  RequestChannelInfo.h
//  YOHo
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestChannelInfo : NSObject
+(void)getChannelArraySuccess:(void(^)(NSMutableDictionary *channelDic))success;
@end
