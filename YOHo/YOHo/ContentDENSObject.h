//
//  ContentDENSObject.h
//
//  Created by mac  on 16/4/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ContentDEDiv;

@interface ContentDENSObject : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) ContentDEDiv *div;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
