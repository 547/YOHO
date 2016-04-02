//
//  RequestContentInfo.h
//  YOHo
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 Seven. All rights reserved.
//

/**请求content信息**/
#import <Foundation/Foundation.h>

@interface RequestContentInfo : NSObject
+(void)getContentinfoWithChannelId:(NSString *)channelId Success:(void(^)(NSMutableArray *contentArray))success;
@end
