//
//  MagazineData.m
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "MagazineData.h"
#import "MagazineMagChapter.h"


NSString *const kMagazineDataMagId = @"magId";
NSString *const kMagazineDataMagType = @"magType";
NSString *const kMagazineDataDescription = @"description";
NSString *const kMagazineDataReleaseDate = @"releaseDate";
NSString *const kMagazineDataBytes = @"bytes";
NSString *const kMagazineDataIdfbytes = @"idfbytes";
NSString *const kMagazineDataDeviceType = @"deviceType";
NSString *const kMagazineDataJournal = @"journal";
NSString *const kMagazineDataTitle = @"title";
NSString *const kMagazineDataSize = @"size";
NSString *const kMagazineDataIdfsize = @"idfsize";
NSString *const kMagazineDataCover = @"cover";
NSString *const kMagazineDataAddress = @"address";
NSString *const kMagazineDataIdfAddress = @"idfAddress";
NSString *const kMagazineDataMagChapter = @"magChapter";
NSString *const kMagazineDataIsH5 = @"isH5";


@interface MagazineData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MagazineData

@synthesize magId = _magId;
@synthesize magType = _magType;
@synthesize dataDescription = _dataDescription;
@synthesize releaseDate = _releaseDate;
@synthesize bytes = _bytes;
@synthesize idfbytes = _idfbytes;
@synthesize deviceType = _deviceType;
@synthesize journal = _journal;
@synthesize title = _title;
@synthesize size = _size;
@synthesize idfsize = _idfsize;
@synthesize cover = _cover;
@synthesize address = _address;
@synthesize idfAddress = _idfAddress;
@synthesize magChapter = _magChapter;
@synthesize isH5 = _isH5;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.magId = [self objectOrNilForKey:kMagazineDataMagId fromDictionary:dict];
            self.magType = [self objectOrNilForKey:kMagazineDataMagType fromDictionary:dict];
            self.dataDescription = [self objectOrNilForKey:kMagazineDataDescription fromDictionary:dict];
            self.releaseDate = [self objectOrNilForKey:kMagazineDataReleaseDate fromDictionary:dict];
            self.bytes = [[self objectOrNilForKey:kMagazineDataBytes fromDictionary:dict] doubleValue];
            self.idfbytes = [[self objectOrNilForKey:kMagazineDataIdfbytes fromDictionary:dict] doubleValue];
            self.deviceType = [self objectOrNilForKey:kMagazineDataDeviceType fromDictionary:dict];
            self.journal = [self objectOrNilForKey:kMagazineDataJournal fromDictionary:dict];
            self.title = [self objectOrNilForKey:kMagazineDataTitle fromDictionary:dict];
            self.size = [[self objectOrNilForKey:kMagazineDataSize fromDictionary:dict] doubleValue];
            self.idfsize = [[self objectOrNilForKey:kMagazineDataIdfsize fromDictionary:dict] doubleValue];
            self.cover = [self objectOrNilForKey:kMagazineDataCover fromDictionary:dict];
            self.address = [self objectOrNilForKey:kMagazineDataAddress fromDictionary:dict];
            self.idfAddress = [self objectOrNilForKey:kMagazineDataIdfAddress fromDictionary:dict];
    NSObject *receivedMagazineMagChapter = [dict objectForKey:kMagazineDataMagChapter];
    NSMutableArray *parsedMagazineMagChapter = [NSMutableArray array];
    if ([receivedMagazineMagChapter isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedMagazineMagChapter) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedMagazineMagChapter addObject:[MagazineMagChapter modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedMagazineMagChapter isKindOfClass:[NSDictionary class]]) {
       [parsedMagazineMagChapter addObject:[MagazineMagChapter modelObjectWithDictionary:(NSDictionary *)receivedMagazineMagChapter]];
    }

    self.magChapter = [NSArray arrayWithArray:parsedMagazineMagChapter];
            self.isH5 = [[self objectOrNilForKey:kMagazineDataIsH5 fromDictionary:dict] doubleValue];

    }
    
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.magId forKey:kMagazineDataMagId];
    [mutableDict setValue:self.magType forKey:kMagazineDataMagType];
    [mutableDict setValue:self.dataDescription forKey:kMagazineDataDescription];
    [mutableDict setValue:self.releaseDate forKey:kMagazineDataReleaseDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bytes] forKey:kMagazineDataBytes];
    [mutableDict setValue:[NSNumber numberWithDouble:self.idfbytes] forKey:kMagazineDataIdfbytes];
    [mutableDict setValue:self.deviceType forKey:kMagazineDataDeviceType];
    [mutableDict setValue:self.journal forKey:kMagazineDataJournal];
    [mutableDict setValue:self.title forKey:kMagazineDataTitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.size] forKey:kMagazineDataSize];
    [mutableDict setValue:[NSNumber numberWithDouble:self.idfsize] forKey:kMagazineDataIdfsize];
    [mutableDict setValue:self.cover forKey:kMagazineDataCover];
    [mutableDict setValue:self.address forKey:kMagazineDataAddress];
    [mutableDict setValue:self.idfAddress forKey:kMagazineDataIdfAddress];
    NSMutableArray *tempArrayForMagChapter = [NSMutableArray array];
    for (NSObject *subArrayObject in self.magChapter) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMagChapter addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMagChapter addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMagChapter] forKey:kMagazineDataMagChapter];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isH5] forKey:kMagazineDataIsH5];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.magId = [aDecoder decodeObjectForKey:kMagazineDataMagId];
    self.magType = [aDecoder decodeObjectForKey:kMagazineDataMagType];
    self.dataDescription = [aDecoder decodeObjectForKey:kMagazineDataDescription];
    self.releaseDate = [aDecoder decodeObjectForKey:kMagazineDataReleaseDate];
    self.bytes = [aDecoder decodeDoubleForKey:kMagazineDataBytes];
    self.idfbytes = [aDecoder decodeDoubleForKey:kMagazineDataIdfbytes];
    self.deviceType = [aDecoder decodeObjectForKey:kMagazineDataDeviceType];
    self.journal = [aDecoder decodeObjectForKey:kMagazineDataJournal];
    self.title = [aDecoder decodeObjectForKey:kMagazineDataTitle];
    self.size = [aDecoder decodeDoubleForKey:kMagazineDataSize];
    self.idfsize = [aDecoder decodeDoubleForKey:kMagazineDataIdfsize];
    self.cover = [aDecoder decodeObjectForKey:kMagazineDataCover];
    self.address = [aDecoder decodeObjectForKey:kMagazineDataAddress];
    self.idfAddress = [aDecoder decodeObjectForKey:kMagazineDataIdfAddress];
    self.magChapter = [aDecoder decodeObjectForKey:kMagazineDataMagChapter];
    self.isH5 = [aDecoder decodeDoubleForKey:kMagazineDataIsH5];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_magId forKey:kMagazineDataMagId];
    [aCoder encodeObject:_magType forKey:kMagazineDataMagType];
    [aCoder encodeObject:_dataDescription forKey:kMagazineDataDescription];
    [aCoder encodeObject:_releaseDate forKey:kMagazineDataReleaseDate];
    [aCoder encodeDouble:_bytes forKey:kMagazineDataBytes];
    [aCoder encodeDouble:_idfbytes forKey:kMagazineDataIdfbytes];
    [aCoder encodeObject:_deviceType forKey:kMagazineDataDeviceType];
    [aCoder encodeObject:_journal forKey:kMagazineDataJournal];
    [aCoder encodeObject:_title forKey:kMagazineDataTitle];
    [aCoder encodeDouble:_size forKey:kMagazineDataSize];
    [aCoder encodeDouble:_idfsize forKey:kMagazineDataIdfsize];
    [aCoder encodeObject:_cover forKey:kMagazineDataCover];
    [aCoder encodeObject:_address forKey:kMagazineDataAddress];
    [aCoder encodeObject:_idfAddress forKey:kMagazineDataIdfAddress];
    [aCoder encodeObject:_magChapter forKey:kMagazineDataMagChapter];
    [aCoder encodeDouble:_isH5 forKey:kMagazineDataIsH5];
}

- (id)copyWithZone:(NSZone *)zone
{
    MagazineData *copy = [[MagazineData alloc] init];
    
    if (copy) {

        copy.magId = [self.magId copyWithZone:zone];
        copy.magType = [self.magType copyWithZone:zone];
        copy.dataDescription = [self.dataDescription copyWithZone:zone];
        copy.releaseDate = [self.releaseDate copyWithZone:zone];
        copy.bytes = self.bytes;
        copy.idfbytes = self.idfbytes;
        copy.deviceType = [self.deviceType copyWithZone:zone];
        copy.journal = [self.journal copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.size = self.size;
        copy.idfsize = self.idfsize;
        copy.cover = [self.cover copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.idfAddress = [self.idfAddress copyWithZone:zone];
        copy.magChapter = [self.magChapter copyWithZone:zone];
        copy.isH5 = self.isH5;
    }
    
    return copy;
}


@end
