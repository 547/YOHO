//
//  NSString+More.m
//  YOHo
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "NSString+More.h"

@implementation NSString (More)

+(BOOL)isValidateRegularExpression:(NSString *)strDestination byExpression:(NSString *)strExpression

{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strExpression];
    
    return [predicate evaluateWithObject:strDestination];
    
}


/**将文件保存到tmp路径*/
+(NSString *)getToTmpWithFileName:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [NSString getFilePathWitName:@"tmp" lastName:@"images" fileName:fileName];
    BOOL isExist = [fileManager fileExistsAtPath:path];
    if (!isExist) {
        [fileManager createFileAtPath:path contents:nil attributes:nil];
    }
    NSLog(@"pa tn ==%@",path);
    return path;

}

/**将文件保存到Documents路径*/
+(NSString *)getToDocumentsWithFileName:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *firstPath = [NSString getFilePathWitName:@"Documents" lastName:@"files"];
    NSString *path = [NSString getFilePathWitName:@"Documents" lastName:@"files" fileName:fileName];
    BOOL isExist = [fileManager fileExistsAtPath:firstPath];
    if (!isExist) {
        [fileManager createDirectoryAtPath:firstPath withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    return path;
    
}

+(NSString *)getFilePathWitName:(NSString *)name lastName:(NSString *)lastName
{
    NSString *path = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/%@/%@/",name,lastName]];
    //    NSLog(@"==p ==%@",path);
    return path;
}

+(NSString *)getFilePathWitName:(NSString *)name lastName:(NSString *)lastName fileName:(NSString *)fileName
{
    NSString *path = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/%@/%@/%@",name,lastName,fileName]];
//    NSLog(@"==p ==%@",path);
    return path;
}

+(CGSize)getFontSize:(NSString *)str
{
    UIFont *font = [UIFont systemFontOfSize:17];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size;
}

@end
