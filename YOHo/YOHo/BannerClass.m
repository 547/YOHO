//
//  BannerClass.m
//  YOHo
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "BannerClass.h"

@implementation BannerClass

/**创建banner*/
+(id)createBannerWithDic:(NSDictionary *)dic
{
    BannerClass *banner = [[BannerClass alloc]init];
    banner.link = [dic objectForKey:@"link"];
    banner.image = [dic objectForKey:@"image"];
    return banner;
}
@end
