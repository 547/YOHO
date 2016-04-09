//
//  SearchTWChannel.m
//
//  Created by mac  on 16/4/8
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "SearchTWChannel.h"


NSString *const kSearchTWChannelId = @"id";
NSString *const kSearchTWChannelChannelNameEn = @"channel_name_en";
NSString *const kSearchTWChannelChannelNameCn = @"channel_name_cn";
NSString *const kSearchTWChannelChannelName = @"channel_name";


@interface SearchTWChannel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SearchTWChannel

@synthesize channelIdentifier = _channelIdentifier;
@synthesize channelNameEn = _channelNameEn;
@synthesize channelNameCn = _channelNameCn;
@synthesize channelName = _channelName;


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
            self.channelIdentifier = [self objectOrNilForKey:kSearchTWChannelId fromDictionary:dict];
            self.channelNameEn = [self objectOrNilForKey:kSearchTWChannelChannelNameEn fromDictionary:dict];
            self.channelNameCn = [self objectOrNilForKey:kSearchTWChannelChannelNameCn fromDictionary:dict];
            self.channelName = [self objectOrNilForKey:kSearchTWChannelChannelName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.channelIdentifier forKey:kSearchTWChannelId];
    [mutableDict setValue:self.channelNameEn forKey:kSearchTWChannelChannelNameEn];
    [mutableDict setValue:self.channelNameCn forKey:kSearchTWChannelChannelNameCn];
    [mutableDict setValue:self.channelName forKey:kSearchTWChannelChannelName];

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

    self.channelIdentifier = [aDecoder decodeObjectForKey:kSearchTWChannelId];
    self.channelNameEn = [aDecoder decodeObjectForKey:kSearchTWChannelChannelNameEn];
    self.channelNameCn = [aDecoder decodeObjectForKey:kSearchTWChannelChannelNameCn];
    self.channelName = [aDecoder decodeObjectForKey:kSearchTWChannelChannelName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_channelIdentifier forKey:kSearchTWChannelId];
    [aCoder encodeObject:_channelNameEn forKey:kSearchTWChannelChannelNameEn];
    [aCoder encodeObject:_channelNameCn forKey:kSearchTWChannelChannelNameCn];
    [aCoder encodeObject:_channelName forKey:kSearchTWChannelChannelName];
}

- (id)copyWithZone:(NSZone *)zone
{
    SearchTWChannel *copy = [[SearchTWChannel alloc] init];
    
    if (copy) {

        copy.channelIdentifier = [self.channelIdentifier copyWithZone:zone];
        copy.channelNameEn = [self.channelNameEn copyWithZone:zone];
        copy.channelNameCn = [self.channelNameCn copyWithZone:zone];
        copy.channelName = [self.channelName copyWithZone:zone];
    }
    
    return copy;
}


@end
