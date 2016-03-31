//
//  SaveToUserDefault.h
//  YOHo
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveToUserDefault : NSObject
+(void)saveString:(NSString *)string key:(NSString *)key;
@end
