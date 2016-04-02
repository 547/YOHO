//
//  MagazineMagChapter.m
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "MagazineMagChapter.h"


NSString *const kMagazineMagChapterSectionBytes = @"sectionBytes";
NSString *const kMagazineMagChapterSectionThumb = @"sectionThumb";
NSString *const kMagazineMagChapterSectionAddress = @"sectionAddress";
NSString *const kMagazineMagChapterSectionSize = @"sectionSize";
NSString *const kMagazineMagChapterDeviceType = @"deviceType";
NSString *const kMagazineMagChapterSectionRealBytes = @"sectionRealBytes";
NSString *const kMagazineMagChapterSectionId = @"sectionId";
NSString *const kMagazineMagChapterSectionTitle = @"sectionTitle";
NSString *const kMagazineMagChapterSectionUrl = @"sectionUrl";


@interface MagazineMagChapter ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MagazineMagChapter

@synthesize sectionBytes = _sectionBytes;
@synthesize sectionThumb = _sectionThumb;
@synthesize sectionAddress = _sectionAddress;
@synthesize sectionSize = _sectionSize;
@synthesize deviceType = _deviceType;
@synthesize sectionRealBytes = _sectionRealBytes;
@synthesize sectionId = _sectionId;
@synthesize sectionTitle = _sectionTitle;
@synthesize sectionUrl = _sectionUrl;


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
            self.sectionBytes = [self objectOrNilForKey:kMagazineMagChapterSectionBytes fromDictionary:dict];
            self.sectionThumb = [self objectOrNilForKey:kMagazineMagChapterSectionThumb fromDictionary:dict];
            self.sectionAddress = [self objectOrNilForKey:kMagazineMagChapterSectionAddress fromDictionary:dict];
            self.sectionSize = [[self objectOrNilForKey:kMagazineMagChapterSectionSize fromDictionary:dict] doubleValue];
            self.deviceType = [self objectOrNilForKey:kMagazineMagChapterDeviceType fromDictionary:dict];
            self.sectionRealBytes = [self objectOrNilForKey:kMagazineMagChapterSectionRealBytes fromDictionary:dict];
            self.sectionId = [self objectOrNilForKey:kMagazineMagChapterSectionId fromDictionary:dict];
            self.sectionTitle = [self objectOrNilForKey:kMagazineMagChapterSectionTitle fromDictionary:dict];
            self.sectionUrl = [self objectOrNilForKey:kMagazineMagChapterSectionUrl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.sectionBytes forKey:kMagazineMagChapterSectionBytes];
    [mutableDict setValue:self.sectionThumb forKey:kMagazineMagChapterSectionThumb];
    [mutableDict setValue:self.sectionAddress forKey:kMagazineMagChapterSectionAddress];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sectionSize] forKey:kMagazineMagChapterSectionSize];
    [mutableDict setValue:self.deviceType forKey:kMagazineMagChapterDeviceType];
    [mutableDict setValue:self.sectionRealBytes forKey:kMagazineMagChapterSectionRealBytes];
    [mutableDict setValue:self.sectionId forKey:kMagazineMagChapterSectionId];
    [mutableDict setValue:self.sectionTitle forKey:kMagazineMagChapterSectionTitle];
    [mutableDict setValue:self.sectionUrl forKey:kMagazineMagChapterSectionUrl];

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

    self.sectionBytes = [aDecoder decodeObjectForKey:kMagazineMagChapterSectionBytes];
    self.sectionThumb = [aDecoder decodeObjectForKey:kMagazineMagChapterSectionThumb];
    self.sectionAddress = [aDecoder decodeObjectForKey:kMagazineMagChapterSectionAddress];
    self.sectionSize = [aDecoder decodeDoubleForKey:kMagazineMagChapterSectionSize];
    self.deviceType = [aDecoder decodeObjectForKey:kMagazineMagChapterDeviceType];
    self.sectionRealBytes = [aDecoder decodeObjectForKey:kMagazineMagChapterSectionRealBytes];
    self.sectionId = [aDecoder decodeObjectForKey:kMagazineMagChapterSectionId];
    self.sectionTitle = [aDecoder decodeObjectForKey:kMagazineMagChapterSectionTitle];
    self.sectionUrl = [aDecoder decodeObjectForKey:kMagazineMagChapterSectionUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_sectionBytes forKey:kMagazineMagChapterSectionBytes];
    [aCoder encodeObject:_sectionThumb forKey:kMagazineMagChapterSectionThumb];
    [aCoder encodeObject:_sectionAddress forKey:kMagazineMagChapterSectionAddress];
    [aCoder encodeDouble:_sectionSize forKey:kMagazineMagChapterSectionSize];
    [aCoder encodeObject:_deviceType forKey:kMagazineMagChapterDeviceType];
    [aCoder encodeObject:_sectionRealBytes forKey:kMagazineMagChapterSectionRealBytes];
    [aCoder encodeObject:_sectionId forKey:kMagazineMagChapterSectionId];
    [aCoder encodeObject:_sectionTitle forKey:kMagazineMagChapterSectionTitle];
    [aCoder encodeObject:_sectionUrl forKey:kMagazineMagChapterSectionUrl];
}

- (id)copyWithZone:(NSZone *)zone
{
    MagazineMagChapter *copy = [[MagazineMagChapter alloc] init];
    
    if (copy) {

        copy.sectionBytes = [self.sectionBytes copyWithZone:zone];
        copy.sectionThumb = [self.sectionThumb copyWithZone:zone];
        copy.sectionAddress = [self.sectionAddress copyWithZone:zone];
        copy.sectionSize = self.sectionSize;
        copy.deviceType = [self.deviceType copyWithZone:zone];
        copy.sectionRealBytes = [self.sectionRealBytes copyWithZone:zone];
        copy.sectionId = [self.sectionId copyWithZone:zone];
        copy.sectionTitle = [self.sectionTitle copyWithZone:zone];
        copy.sectionUrl = [self.sectionUrl copyWithZone:zone];
    }
    
    return copy;
}


@end
