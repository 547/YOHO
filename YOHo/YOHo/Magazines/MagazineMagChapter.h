//
//  MagazineMagChapter.h
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MagazineMagChapter : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *sectionBytes;
@property (nonatomic, strong) NSString *sectionThumb;
@property (nonatomic, strong) NSString *sectionAddress;
@property (nonatomic, assign) double sectionSize;
@property (nonatomic, strong) NSString *deviceType;
@property (nonatomic, strong) NSString *sectionRealBytes;
@property (nonatomic, strong) NSString *sectionId;
@property (nonatomic, strong) NSString *sectionTitle;
@property (nonatomic, strong) NSString *sectionUrl;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
