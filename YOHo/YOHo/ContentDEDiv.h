//
//  ContentDEDiv.h
//
//  Created by mac  on 16/4/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ContentDEDiv : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *div;
@property (nonatomic, strong) NSString *style;
@property (nonatomic, strong) NSArray *img;
@property (nonatomic, strong) NSArray *br;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
