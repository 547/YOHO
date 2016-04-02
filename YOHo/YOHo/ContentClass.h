//
//  ContentClass.h
//  YOHo
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 Seven. All rights reserved.
//

/**内容*/
#import <Foundation/Foundation.h>
#import "ChannelClass.h"
@interface ContentClass : NSObject
@property(nonatomic,strong)ChannelClass *channel;
@property(nonatomic,copy)NSString *publishURL;
@property(nonatomic,copy)NSString *contentId;
@property(nonatomic,copy)NSString *cid;
@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSString *contentType;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subtitle;
@property(nonatomic,copy)NSString *summary;
@property(nonatomic,copy)NSString *publishTime;
+(id)createContentWithDic:(NSDictionary *)dic;
@end
