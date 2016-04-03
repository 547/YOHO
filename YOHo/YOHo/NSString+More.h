//
//  NSString+More.h
//  YOHo
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (More)
+(NSString *)getToTmpWithFileName:(NSString *)fileName;
+(CGSize)getFontSize:(NSString *)str;
/**将文件保存到Documents路径*/
+(NSString *)getToDocumentsWithFileName:(NSString *)fileName;
@end
