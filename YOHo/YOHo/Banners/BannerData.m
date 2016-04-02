//
//  BannerData.m
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "BannerData.h"


NSString *const kBannerDataStatus = @"status";
NSString *const kBannerDataDelTime = @"del_time";
NSString *const kBannerDataMergeId = @"mergeId";
NSString *const kBannerDataFrame = @"frame";
NSString *const kBannerDataApp = @"app";
NSString *const kBannerDataMagazine = @"magazine";
NSString *const kBannerDataDelay = @"delay";
NSString *const kBannerDataLink = @"link";
NSString *const kBannerDataImage = @"image";
NSString *const kBannerDataLinkType = @"linkType";
NSString *const kBannerDataFeature = @"feature";


@interface BannerData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BannerData

@synthesize status = _status;
@synthesize delTime = _delTime;
@synthesize mergeId = _mergeId;
@synthesize frame = _frame;
@synthesize app = _app;
@synthesize magazine = _magazine;
@synthesize delay = _delay;
@synthesize link = _link;
@synthesize image = _image;
@synthesize linkType = _linkType;
@synthesize feature = _feature;


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
            self.status = [self objectOrNilForKey:kBannerDataStatus fromDictionary:dict];
            self.delTime = [self objectOrNilForKey:kBannerDataDelTime fromDictionary:dict];
            self.mergeId = [self objectOrNilForKey:kBannerDataMergeId fromDictionary:dict];
            self.frame = [self objectOrNilForKey:kBannerDataFrame fromDictionary:dict];
            self.app = [self objectOrNilForKey:kBannerDataApp fromDictionary:dict];
            self.magazine = [self objectOrNilForKey:kBannerDataMagazine fromDictionary:dict];
            self.delay = [self objectOrNilForKey:kBannerDataDelay fromDictionary:dict];
            self.link = [self objectOrNilForKey:kBannerDataLink fromDictionary:dict];
            self.image = [self objectOrNilForKey:kBannerDataImage fromDictionary:dict];
            self.linkType = [[self objectOrNilForKey:kBannerDataLinkType fromDictionary:dict] doubleValue];
            self.feature = [self objectOrNilForKey:kBannerDataFeature fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kBannerDataStatus];
    [mutableDict setValue:self.delTime forKey:kBannerDataDelTime];
    [mutableDict setValue:self.mergeId forKey:kBannerDataMergeId];
    [mutableDict setValue:self.frame forKey:kBannerDataFrame];
    [mutableDict setValue:self.app forKey:kBannerDataApp];
    [mutableDict setValue:self.magazine forKey:kBannerDataMagazine];
    [mutableDict setValue:self.delay forKey:kBannerDataDelay];
    [mutableDict setValue:self.link forKey:kBannerDataLink];
    [mutableDict setValue:self.image forKey:kBannerDataImage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.linkType] forKey:kBannerDataLinkType];
    [mutableDict setValue:self.feature forKey:kBannerDataFeature];

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

    self.status = [aDecoder decodeObjectForKey:kBannerDataStatus];
    self.delTime = [aDecoder decodeObjectForKey:kBannerDataDelTime];
    self.mergeId = [aDecoder decodeObjectForKey:kBannerDataMergeId];
    self.frame = [aDecoder decodeObjectForKey:kBannerDataFrame];
    self.app = [aDecoder decodeObjectForKey:kBannerDataApp];
    self.magazine = [aDecoder decodeObjectForKey:kBannerDataMagazine];
    self.delay = [aDecoder decodeObjectForKey:kBannerDataDelay];
    self.link = [aDecoder decodeObjectForKey:kBannerDataLink];
    self.image = [aDecoder decodeObjectForKey:kBannerDataImage];
    self.linkType = [aDecoder decodeDoubleForKey:kBannerDataLinkType];
    self.feature = [aDecoder decodeObjectForKey:kBannerDataFeature];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kBannerDataStatus];
    [aCoder encodeObject:_delTime forKey:kBannerDataDelTime];
    [aCoder encodeObject:_mergeId forKey:kBannerDataMergeId];
    [aCoder encodeObject:_frame forKey:kBannerDataFrame];
    [aCoder encodeObject:_app forKey:kBannerDataApp];
    [aCoder encodeObject:_magazine forKey:kBannerDataMagazine];
    [aCoder encodeObject:_delay forKey:kBannerDataDelay];
    [aCoder encodeObject:_link forKey:kBannerDataLink];
    [aCoder encodeObject:_image forKey:kBannerDataImage];
    [aCoder encodeDouble:_linkType forKey:kBannerDataLinkType];
    [aCoder encodeObject:_feature forKey:kBannerDataFeature];
}

- (id)copyWithZone:(NSZone *)zone
{
    BannerData *copy = [[BannerData alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.delTime = [self.delTime copyWithZone:zone];
        copy.mergeId = [self.mergeId copyWithZone:zone];
        copy.frame = [self.frame copyWithZone:zone];
        copy.app = [self.app copyWithZone:zone];
        copy.magazine = [self.magazine copyWithZone:zone];
        copy.delay = [self.delay copyWithZone:zone];
        copy.link = [self.link copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.linkType = self.linkType;
        copy.feature = [self.feature copyWithZone:zone];
    }
    
    return copy;
}


@end
