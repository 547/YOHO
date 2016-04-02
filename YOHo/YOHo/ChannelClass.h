//
//  ChannelClass.h
//  YOHo
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelClass : NSObject
@property(nonatomic,copy)NSString *channel_id;
@property(nonatomic,copy)NSString *channel_name_cn;
@property(nonatomic,copy)NSString *channel_name_en;
@property(nonatomic,copy)NSString *channel_name;
+(id)createChannelWithDic:(NSDictionary *)dic;
@end
