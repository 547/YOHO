//
//  MagazineData.h
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MagazineData : NSObject <NSCoding, NSCopying>
@property (nonatomic,strong)NSData *resumeData;
@property (nonatomic,copy)NSString *savePath;
@property (nonatomic, strong) NSString *magId;
@property (nonatomic, strong) NSString *magType;
@property (nonatomic, strong) NSString *dataDescription;
@property (nonatomic, strong) NSString *releaseDate;
@property (nonatomic, assign) double bytes;
@property (nonatomic, assign) double idfbytes;
@property (nonatomic, strong) NSString *deviceType;
@property (nonatomic, strong) NSString *journal;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double size;
@property (nonatomic, assign) double idfsize;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *idfAddress;
@property (nonatomic, strong) NSArray *magChapter;
@property (nonatomic, assign) double isH5;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
