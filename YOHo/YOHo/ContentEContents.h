//
//  ContentEContents.h
//
//  Created by mac  on 16/4/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ContentEContents : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *updateMd5;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *gps;
@property (nonatomic, strong) NSString *total;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *contentsIdentifier;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, assign) double contentType;
@property (nonatomic, assign) double height;
@property (nonatomic, assign) double width;
@property (nonatomic, strong) NSString *publishTime;
@property (nonatomic, strong) NSString *titleFont;
@property (nonatomic, strong) NSArray *editor;
@property (nonatomic, strong) NSString *publishURL;
@property (nonatomic, strong) NSString *subTitleFont;
@property (nonatomic, assign) double app;
@property (nonatomic, strong) NSString *address;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
