//
//  JudgeLoginClass.m
//  YOHo
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "JudgeLoginClass.h"

@implementation JudgeLoginClass
+(BOOL)isLogin
{
    NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
    NSString *token = [us objectForKey:@"token"];
    if (token.length>0) {
        return YES;
    }else{
    return NO;
    }
    
}
@end
