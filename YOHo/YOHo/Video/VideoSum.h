//
//  VideoSum.h
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VideoData;

@interface VideoSum : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) VideoData *data;
@property (nonatomic, assign) double code;
@property (nonatomic, strong) NSString *message;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
