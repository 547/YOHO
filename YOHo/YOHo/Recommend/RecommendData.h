//
//  RecommendData.h
//
//  Created by mac  on 16/4/8
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface RecommendData : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double isPop;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSString *subChannelID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, strong) NSString *channelID;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, assign) double contentType;
@property (nonatomic, assign) double height;
@property (nonatomic, strong) NSString *subChannelName;
@property (nonatomic, assign) double width;
@property (nonatomic, strong) NSString *publishTime;
@property (nonatomic, strong) NSString *titleFont;
@property (nonatomic, strong) NSString *publishURL;
@property (nonatomic, strong) NSString *subTitleFont;
@property (nonatomic, assign) double app;
@property (nonatomic, strong) NSString *channelName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
