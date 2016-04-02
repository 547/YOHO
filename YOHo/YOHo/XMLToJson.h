//
//  XMLToJson.h
//  YOHo
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 Seven. All rights reserved.
//
/**xml转成Json*/
#import <Foundation/Foundation.h>
#import "XMLReader.h"
@interface XMLToJson : NSObject
+(NSDictionary *)XMLTODicWithNSString:(NSString *)xmlStr;
@end
