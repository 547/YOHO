//
//  RecommendData.m
//
//  Created by mac  on 16/4/8
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "RecommendData.h"


NSString *const kRecommendDataIsPop = @"isPop";
NSString *const kRecommendDataColor = @"color";
NSString *const kRecommendDataSubChannelID = @"subChannelID";
NSString *const kRecommendDataTitle = @"title";
NSString *const kRecommendDataSummary = @"summary";
NSString *const kRecommendDataImage = @"image";
NSString *const kRecommendDataCid = @"cid";
NSString *const kRecommendDataId = @"id";
NSString *const kRecommendDataChannelID = @"channelID";
NSString *const kRecommendDataSubtitle = @"subtitle";
NSString *const kRecommendDataContentType = @"contentType";
NSString *const kRecommendDataHeight = @"height";
NSString *const kRecommendDataSubChannelName = @"subChannelName";
NSString *const kRecommendDataWidth = @"width";
NSString *const kRecommendDataPublishTime = @"publishTime";
NSString *const kRecommendDataTitleFont = @"titleFont";
NSString *const kRecommendDataPublishURL = @"publishURL";
NSString *const kRecommendDataSubTitleFont = @"subTitleFont";
NSString *const kRecommendDataApp = @"app";
NSString *const kRecommendDataChannelName = @"channelName";


@interface RecommendData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RecommendData

@synthesize isPop = _isPop;
@synthesize color = _color;
@synthesize subChannelID = _subChannelID;
@synthesize title = _title;
@synthesize summary = _summary;
@synthesize image = _image;
@synthesize cid = _cid;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize channelID = _channelID;
@synthesize subtitle = _subtitle;
@synthesize contentType = _contentType;
@synthesize height = _height;
@synthesize subChannelName = _subChannelName;
@synthesize width = _width;
@synthesize publishTime = _publishTime;
@synthesize titleFont = _titleFont;
@synthesize publishURL = _publishURL;
@synthesize subTitleFont = _subTitleFont;
@synthesize app = _app;
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
            self.isPop = [[self objectOrNilForKey:kRecommendDataIsPop fromDictionary:dict] doubleValue];
            self.color = [self objectOrNilForKey:kRecommendDataColor fromDictionary:dict];
            self.subChannelID = [self objectOrNilForKey:kRecommendDataSubChannelID fromDictionary:dict];
            self.title = [self objectOrNilForKey:kRecommendDataTitle fromDictionary:dict];
            self.summary = [self objectOrNilForKey:kRecommendDataSummary fromDictionary:dict];
            self.image = [self objectOrNilForKey:kRecommendDataImage fromDictionary:dict];
            self.cid = [self objectOrNilForKey:kRecommendDataCid fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kRecommendDataId fromDictionary:dict];
            self.channelID = [self objectOrNilForKey:kRecommendDataChannelID fromDictionary:dict];
            self.subtitle = [self objectOrNilForKey:kRecommendDataSubtitle fromDictionary:dict];
            self.contentType = [[self objectOrNilForKey:kRecommendDataContentType fromDictionary:dict] doubleValue];
            self.height = [[self objectOrNilForKey:kRecommendDataHeight fromDictionary:dict] doubleValue];
            self.subChannelName = [self objectOrNilForKey:kRecommendDataSubChannelName fromDictionary:dict];
            self.width = [[self objectOrNilForKey:kRecommendDataWidth fromDictionary:dict] doubleValue];
            self.publishTime = [self objectOrNilForKey:kRecommendDataPublishTime fromDictionary:dict];
            self.titleFont = [self objectOrNilForKey:kRecommendDataTitleFont fromDictionary:dict];
            self.publishURL = [self objectOrNilForKey:kRecommendDataPublishURL fromDictionary:dict];
            self.subTitleFont = [self objectOrNilForKey:kRecommendDataSubTitleFont fromDictionary:dict];
            self.app = [[self objectOrNilForKey:kRecommendDataApp fromDictionary:dict] doubleValue];
            self.channelName = [self objectOrNilForKey:kRecommendDataChannelName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isPop] forKey:kRecommendDataIsPop];
    [mutableDict setValue:self.color forKey:kRecommendDataColor];
    [mutableDict setValue:self.subChannelID forKey:kRecommendDataSubChannelID];
    [mutableDict setValue:self.title forKey:kRecommendDataTitle];
    [mutableDict setValue:self.summary forKey:kRecommendDataSummary];
    [mutableDict setValue:self.image forKey:kRecommendDataImage];
    [mutableDict setValue:self.cid forKey:kRecommendDataCid];
    [mutableDict setValue:self.dataIdentifier forKey:kRecommendDataId];
    [mutableDict setValue:self.channelID forKey:kRecommendDataChannelID];
    [mutableDict setValue:self.subtitle forKey:kRecommendDataSubtitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.contentType] forKey:kRecommendDataContentType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.height] forKey:kRecommendDataHeight];
    [mutableDict setValue:self.subChannelName forKey:kRecommendDataSubChannelName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.width] forKey:kRecommendDataWidth];
    [mutableDict setValue:self.publishTime forKey:kRecommendDataPublishTime];
    [mutableDict setValue:self.titleFont forKey:kRecommendDataTitleFont];
    [mutableDict setValue:self.publishURL forKey:kRecommendDataPublishURL];
    [mutableDict setValue:self.subTitleFont forKey:kRecommendDataSubTitleFont];
    [mutableDict setValue:[NSNumber numberWithDouble:self.app] forKey:kRecommendDataApp];
    [mutableDict setValue:self.channelName forKey:kRecommendDataChannelName];

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

    self.isPop = [aDecoder decodeDoubleForKey:kRecommendDataIsPop];
    self.color = [aDecoder decodeObjectForKey:kRecommendDataColor];
    self.subChannelID = [aDecoder decodeObjectForKey:kRecommendDataSubChannelID];
    self.title = [aDecoder decodeObjectForKey:kRecommendDataTitle];
    self.summary = [aDecoder decodeObjectForKey:kRecommendDataSummary];
    self.image = [aDecoder decodeObjectForKey:kRecommendDataImage];
    self.cid = [aDecoder decodeObjectForKey:kRecommendDataCid];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kRecommendDataId];
    self.channelID = [aDecoder decodeObjectForKey:kRecommendDataChannelID];
    self.subtitle = [aDecoder decodeObjectForKey:kRecommendDataSubtitle];
    self.contentType = [aDecoder decodeDoubleForKey:kRecommendDataContentType];
    self.height = [aDecoder decodeDoubleForKey:kRecommendDataHeight];
    self.subChannelName = [aDecoder decodeObjectForKey:kRecommendDataSubChannelName];
    self.width = [aDecoder decodeDoubleForKey:kRecommendDataWidth];
    self.publishTime = [aDecoder decodeObjectForKey:kRecommendDataPublishTime];
    self.titleFont = [aDecoder decodeObjectForKey:kRecommendDataTitleFont];
    self.publishURL = [aDecoder decodeObjectForKey:kRecommendDataPublishURL];
    self.subTitleFont = [aDecoder decodeObjectForKey:kRecommendDataSubTitleFont];
    self.app = [aDecoder decodeDoubleForKey:kRecommendDataApp];
    self.channelName = [aDecoder decodeObjectForKey:kRecommendDataChannelName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_isPop forKey:kRecommendDataIsPop];
    [aCoder encodeObject:_color forKey:kRecommendDataColor];
    [aCoder encodeObject:_subChannelID forKey:kRecommendDataSubChannelID];
    [aCoder encodeObject:_title forKey:kRecommendDataTitle];
    [aCoder encodeObject:_summary forKey:kRecommendDataSummary];
    [aCoder encodeObject:_image forKey:kRecommendDataImage];
    [aCoder encodeObject:_cid forKey:kRecommendDataCid];
    [aCoder encodeObject:_dataIdentifier forKey:kRecommendDataId];
    [aCoder encodeObject:_channelID forKey:kRecommendDataChannelID];
    [aCoder encodeObject:_subtitle forKey:kRecommendDataSubtitle];
    [aCoder encodeDouble:_contentType forKey:kRecommendDataContentType];
    [aCoder encodeDouble:_height forKey:kRecommendDataHeight];
    [aCoder encodeObject:_subChannelName forKey:kRecommendDataSubChannelName];
    [aCoder encodeDouble:_width forKey:kRecommendDataWidth];
    [aCoder encodeObject:_publishTime forKey:kRecommendDataPublishTime];
    [aCoder encodeObject:_titleFont forKey:kRecommendDataTitleFont];
    [aCoder encodeObject:_publishURL forKey:kRecommendDataPublishURL];
    [aCoder encodeObject:_subTitleFont forKey:kRecommendDataSubTitleFont];
    [aCoder encodeDouble:_app forKey:kRecommendDataApp];
    [aCoder encodeObject:_channelName forKey:kRecommendDataChannelName];
}

- (id)copyWithZone:(NSZone *)zone
{
    RecommendData *copy = [[RecommendData alloc] init];
    
    if (copy) {

        copy.isPop = self.isPop;
        copy.color = [self.color copyWithZone:zone];
        copy.subChannelID = [self.subChannelID copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.summary = [self.summary copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.cid = [self.cid copyWithZone:zone];
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.channelID = [self.channelID copyWithZone:zone];
        copy.subtitle = [self.subtitle copyWithZone:zone];
        copy.contentType = self.contentType;
        copy.height = self.height;
        copy.subChannelName = [self.subChannelName copyWithZone:zone];
        copy.width = self.width;
        copy.publishTime = [self.publishTime copyWithZone:zone];
        copy.titleFont = [self.titleFont copyWithZone:zone];
        copy.publishURL = [self.publishURL copyWithZone:zone];
        copy.subTitleFont = [self.subTitleFont copyWithZone:zone];
        copy.app = self.app;
        copy.channelName = [self.channelName copyWithZone:zone];
    }
    
    return copy;
}


@end
