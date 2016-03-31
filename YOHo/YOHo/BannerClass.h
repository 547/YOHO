//
//  BannerClass.h
//  YOHo
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 Seven. All rights reserved.
//
/**广告招牌模型*/
#import <Foundation/Foundation.h>

@interface BannerClass : NSObject
@property(nonatomic,strong)NSString *link;
@property(nonatomic,strong)NSString *image;
+(id)createBannerWithDic:(NSDictionary *)dic;
@end
