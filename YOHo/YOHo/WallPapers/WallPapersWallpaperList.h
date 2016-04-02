//
//  WallPapersWallpaperList.h
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WallPapersWallpaperList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *journal;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *month;
@property (nonatomic, strong) NSArray *images;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
