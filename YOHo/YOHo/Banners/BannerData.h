//
//  BannerData.h
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BannerData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *delTime;
@property (nonatomic, strong) NSString *mergeId;
@property (nonatomic, strong) NSString *frame;
@property (nonatomic, strong) NSString *app;
@property (nonatomic, strong) NSString *magazine;
@property (nonatomic, strong) NSString *delay;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, assign) double linkType;
@property (nonatomic, strong) NSString *feature;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
