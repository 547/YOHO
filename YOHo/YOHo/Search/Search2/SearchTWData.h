//
//  SearchTWData.h
//
//  Created by mac  on 16/4/8
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SearchTWData : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double total;
@property (nonatomic, strong) NSArray *list;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
