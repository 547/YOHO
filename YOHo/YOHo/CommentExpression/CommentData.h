//
//  CommentData.h
//
//  Created by mac  on 16/4/9
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CommentData : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double wowCount;
@property (nonatomic, assign) double userWow;
@property (nonatomic, assign) double wtfCount;
@property (nonatomic, assign) double userZzz;
@property (nonatomic, assign) double zzzCount;
@property (nonatomic, assign) double userWtf;
@property (nonatomic, assign) double commentCount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
