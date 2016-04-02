//
//  RequestContentDetail.h
//  YOHo
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "XMLToJson.h"
#import "DataModels.h"
@interface RequestContentDetail : NSObject
+(void)getContentDetailWithCIdOrLink:(NSString *)cId Success:(void(^)(ContentENSObject *contentDetail))success;
@end
