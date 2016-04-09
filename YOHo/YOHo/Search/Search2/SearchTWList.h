//
//  SearchTWList.h
//
//  Created by mac  on 16/4/8
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SearchTWChannel;

@interface SearchTWList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *listIdentifier;
@property (nonatomic, strong) NSString *videoUrl;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *publishURL;
@property (nonatomic, strong) SearchTWChannel *channel;
@property (nonatomic, strong) NSString *subTitleFont;
@property (nonatomic, assign) double width;
@property (nonatomic, assign) double contentType;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *updateMd5;
@property (nonatomic, strong) NSString *titleFont;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *publishTime;
@property (nonatomic, assign) double height;
@property (nonatomic, assign) double app;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
