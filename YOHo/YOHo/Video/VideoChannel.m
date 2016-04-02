//
//  VideoChannel.m
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "VideoChannel.h"


NSString *const kVideoChannelId = @"id";
NSString *const kVideoChannelChannelNameEn = @"channel_name_en";
NSString *const kVideoChannelChannelNameCn = @"channel_name_cn";
NSString *const kVideoChannelChannelName = @"channel_name";


@interface VideoChannel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation VideoChannel

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
            self.channelIdentifier = [self objectOrNilForKey:kVideoChannelId fromDictionary:dict];
            self.channelNameEn = [self objectOrNilForKey:kVideoChannelChannelNameEn fromDictionary:dict];
            self.channelNameCn = [self objectOrNilForKey:kVideoChannelChannelNameCn fromDictionary:dict];
            self.channelName = [self objectOrNilForKey:kVideoChannelChannelName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.channelIdentifier forKey:kVideoChannelId];
    [mutableDict setValue:self.channelNameEn forKey:kVideoChannelChannelNameEn];
    [mutableDict setValue:self.channelNameCn forKey:kVideoChannelChannelNameCn];
    [mutableDict setValue:self.channelName forKey:kVideoChannelChannelName];

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

    self.channelIdentifier = [aDecoder decodeObjectForKey:kVideoChannelId];
    self.channelNameEn = [aDecoder decodeObjectForKey:kVideoChannelChannelNameEn];
    self.channelNameCn = [aDecoder decodeObjectForKey:kVideoChannelChannelNameCn];
    self.channelName = [aDecoder decodeObjectForKey:kVideoChannelChannelName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_channelIdentifier forKey:kVideoChannelId];
    [aCoder encodeObject:_channelNameEn forKey:kVideoChannelChannelNameEn];
    [aCoder encodeObject:_channelNameCn forKey:kVideoChannelChannelNameCn];
    [aCoder encodeObject:_channelName forKey:kVideoChannelChannelName];
}

- (id)copyWithZone:(NSZone *)zone
{
    VideoChannel *copy = [[VideoChannel alloc] init];
    
    if (copy) {

        copy.channelIdentifier = [self.channelIdentifier copyWithZone:zone];
        copy.channelNameEn = [self.channelNameEn copyWithZone:zone];
        copy.channelNameCn = [self.channelNameCn copyWithZone:zone];
        copy.channelName = [self.channelName copyWithZone:zone];
    }
    
    return copy;
}


@end
