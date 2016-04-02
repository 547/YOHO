//
//  XMLToJson.m
//  YOHo
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "XMLToJson.h"
#import "JSONKit.h"
@implementation XMLToJson
+(NSDictionary *)XMLTODicWithNSString:(NSString *)xmlStr
{

    NSError *error = nil;
    //xml转字典
    NSDictionary *dic = [XMLReader dictionaryForXMLString:xmlStr error:&error];
    NSString *json = [dic JSONString];
    
   NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    
    NSLog(@"=js===========\n%@",json);
    return jsData;
}
@end
