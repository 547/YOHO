//
//  ChannelClass.m
//  YOHo
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ChannelClass.h"

@implementation ChannelClass

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _channel_id = (NSString *)value;
    }
}

+(id)createChannelWithDic:(NSDictionary *)dic
{
    ChannelClass *channel = [[ChannelClass alloc]init];
    NSArray *allkeys = [dic allKeys];
    for (NSString *key in allkeys) {
        NSString *value = [dic objectForKey:key];
        [channel setValue:value forKeyPath:key];
        if ([key isEqualToString:@"id"]) {
            channel.channel_id = value;
        }
    }
    return channel;
}
@end
