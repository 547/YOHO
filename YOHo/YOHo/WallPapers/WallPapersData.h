//
//  WallPapersData.h
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WallPapersData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *total;
@property (nonatomic, strong) NSArray *wallpaperList;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
