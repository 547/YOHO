//
//  SaveToUserDefault.m
//  YOHo
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "SaveToUserDefault.h"

@implementation SaveToUserDefault
+(void)saveString:(NSString *)string key:(NSString *)key
{
    NSUserDefaults *userDe = [NSUserDefaults standardUserDefaults];
    [userDe setObject:string forKey:key];
}
@end
