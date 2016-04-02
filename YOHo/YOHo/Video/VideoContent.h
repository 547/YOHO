//
//  VideoContent.h
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VideoChannel;

@interface VideoContent : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *contentIdentifier;
@property (nonatomic, strong) NSString *videoUrl;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *publishURL;
@property (nonatomic, strong) VideoChannel *channel;
@property (nonatomic, strong) NSString *subTitleFont;
@property (nonatomic, assign) double width;
@property (nonatomic, assign) double contentType;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *updateMd5;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *titleFont;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *publishTime;
@property (nonatomic, assign) double height;
@property (nonatomic, strong) NSString *app;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
