//
//  ContentClass.m
//  YOHo
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ContentClass.h"

@implementation ContentClass

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

    if ([key isEqualToString:@"id"])
    {
        _contentId =(NSString *)value;
        
    }
    
}

+(id)createContentWithDic:(NSDictionary *)dic
{
    ContentClass *content = [[ContentClass alloc]init];
    NSArray *allkeys = [dic allKeys];
    for (NSString *key in allkeys) {
        NSString *value = [dic objectForKey:key];
        [content setValue:value forKeyPath:key];
        if ([key isEqualToString:@"id"])
        {
            content.contentId =value;
            
        }
        if ([key isEqualToString:@"channel"]) {
            NSDictionary *chdic = [dic objectForKey:key];
            content.channel = [ChannelClass createChannelWithDic:chdic];
        }
    }
    return content;
}
@end
