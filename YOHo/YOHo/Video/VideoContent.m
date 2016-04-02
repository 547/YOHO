//
//  VideoContent.m
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "VideoContent.h"
#import "VideoChannel.h"


NSString *const kVideoContentId = @"id";
NSString *const kVideoContentVideoUrl = @"videoUrl";
NSString *const kVideoContentSubtitle = @"subtitle";
NSString *const kVideoContentPublishURL = @"publishURL";
NSString *const kVideoContentChannel = @"channel";
NSString *const kVideoContentSubTitleFont = @"subTitleFont";
NSString *const kVideoContentWidth = @"width";
NSString *const kVideoContentContentType = @"contentType";
NSString *const kVideoContentCid = @"cid";
NSString *const kVideoContentTitle = @"title";
NSString *const kVideoContentUpdateMd5 = @"updateMd5";
NSString *const kVideoContentImage = @"image";
NSString *const kVideoContentTitleFont = @"titleFont";
NSString *const kVideoContentSummary = @"summary";
NSString *const kVideoContentPublishTime = @"publishTime";
NSString *const kVideoContentHeight = @"height";
NSString *const kVideoContentApp = @"app";


@interface VideoContent ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation VideoContent

@synthesize contentIdentifier = _contentIdentifier;
@synthesize videoUrl = _videoUrl;
@synthesize subtitle = _subtitle;
@synthesize publishURL = _publishURL;
@synthesize channel = _channel;
@synthesize subTitleFont = _subTitleFont;
@synthesize width = _width;
@synthesize contentType = _contentType;
@synthesize cid = _cid;
@synthesize title = _title;
@synthesize updateMd5 = _updateMd5;
@synthesize image = _image;
@synthesize titleFont = _titleFont;
@synthesize summary = _summary;
@synthesize publishTime = _publishTime;
@synthesize height = _height;
@synthesize app = _app;


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
            self.contentIdentifier = [self objectOrNilForKey:kVideoContentId fromDictionary:dict];
            self.videoUrl = [self objectOrNilForKey:kVideoContentVideoUrl fromDictionary:dict];
            self.subtitle = [self objectOrNilForKey:kVideoContentSubtitle fromDictionary:dict];
            self.publishURL = [self objectOrNilForKey:kVideoContentPublishURL fromDictionary:dict];
            self.channel = [VideoChannel modelObjectWithDictionary:[dict objectForKey:kVideoContentChannel]];
            self.subTitleFont = [self objectOrNilForKey:kVideoContentSubTitleFont fromDictionary:dict];
            self.width = [[self objectOrNilForKey:kVideoContentWidth fromDictionary:dict] doubleValue];
            self.contentType = [[self objectOrNilForKey:kVideoContentContentType fromDictionary:dict] doubleValue];
            self.cid = [self objectOrNilForKey:kVideoContentCid fromDictionary:dict];
            self.title = [self objectOrNilForKey:kVideoContentTitle fromDictionary:dict];
            self.updateMd5 = [self objectOrNilForKey:kVideoContentUpdateMd5 fromDictionary:dict];
            self.image = [self objectOrNilForKey:kVideoContentImage fromDictionary:dict];
            self.titleFont = [self objectOrNilForKey:kVideoContentTitleFont fromDictionary:dict];
            self.summary = [self objectOrNilForKey:kVideoContentSummary fromDictionary:dict];
            self.publishTime = [self objectOrNilForKey:kVideoContentPublishTime fromDictionary:dict];
            self.height = [[self objectOrNilForKey:kVideoContentHeight fromDictionary:dict] doubleValue];
            self.app = [self objectOrNilForKey:kVideoContentApp fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.contentIdentifier forKey:kVideoContentId];
    [mutableDict setValue:self.videoUrl forKey:kVideoContentVideoUrl];
    [mutableDict setValue:self.subtitle forKey:kVideoContentSubtitle];
    [mutableDict setValue:self.publishURL forKey:kVideoContentPublishURL];
    [mutableDict setValue:[self.channel dictionaryRepresentation] forKey:kVideoContentChannel];
    [mutableDict setValue:self.subTitleFont forKey:kVideoContentSubTitleFont];
    [mutableDict setValue:[NSNumber numberWithDouble:self.width] forKey:kVideoContentWidth];
    [mutableDict setValue:[NSNumber numberWithDouble:self.contentType] forKey:kVideoContentContentType];
    [mutableDict setValue:self.cid forKey:kVideoContentCid];
    [mutableDict setValue:self.title forKey:kVideoContentTitle];
    [mutableDict setValue:self.updateMd5 forKey:kVideoContentUpdateMd5];
    [mutableDict setValue:self.image forKey:kVideoContentImage];
    [mutableDict setValue:self.titleFont forKey:kVideoContentTitleFont];
    [mutableDict setValue:self.summary forKey:kVideoContentSummary];
    [mutableDict setValue:self.publishTime forKey:kVideoContentPublishTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.height] forKey:kVideoContentHeight];
    [mutableDict setValue:self.app forKey:kVideoContentApp];

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

    self.contentIdentifier = [aDecoder decodeObjectForKey:kVideoContentId];
    self.videoUrl = [aDecoder decodeObjectForKey:kVideoContentVideoUrl];
    self.subtitle = [aDecoder decodeObjectForKey:kVideoContentSubtitle];
    self.publishURL = [aDecoder decodeObjectForKey:kVideoContentPublishURL];
    self.channel = [aDecoder decodeObjectForKey:kVideoContentChannel];
    self.subTitleFont = [aDecoder decodeObjectForKey:kVideoContentSubTitleFont];
    self.width = [aDecoder decodeDoubleForKey:kVideoContentWidth];
    self.contentType = [aDecoder decodeDoubleForKey:kVideoContentContentType];
    self.cid = [aDecoder decodeObjectForKey:kVideoContentCid];
    self.title = [aDecoder decodeObjectForKey:kVideoContentTitle];
    self.updateMd5 = [aDecoder decodeObjectForKey:kVideoContentUpdateMd5];
    self.image = [aDecoder decodeObjectForKey:kVideoContentImage];
    self.titleFont = [aDecoder decodeObjectForKey:kVideoContentTitleFont];
    self.summary = [aDecoder decodeObjectForKey:kVideoContentSummary];
    self.publishTime = [aDecoder decodeObjectForKey:kVideoContentPublishTime];
    self.height = [aDecoder decodeDoubleForKey:kVideoContentHeight];
    self.app = [aDecoder decodeObjectForKey:kVideoContentApp];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_contentIdentifier forKey:kVideoContentId];
    [aCoder encodeObject:_videoUrl forKey:kVideoContentVideoUrl];
    [aCoder encodeObject:_subtitle forKey:kVideoContentSubtitle];
    [aCoder encodeObject:_publishURL forKey:kVideoContentPublishURL];
    [aCoder encodeObject:_channel forKey:kVideoContentChannel];
    [aCoder encodeObject:_subTitleFont forKey:kVideoContentSubTitleFont];
    [aCoder encodeDouble:_width forKey:kVideoContentWidth];
    [aCoder encodeDouble:_contentType forKey:kVideoContentContentType];
    [aCoder encodeObject:_cid forKey:kVideoContentCid];
    [aCoder encodeObject:_title forKey:kVideoContentTitle];
    [aCoder encodeObject:_updateMd5 forKey:kVideoContentUpdateMd5];
    [aCoder encodeObject:_image forKey:kVideoContentImage];
    [aCoder encodeObject:_titleFont forKey:kVideoContentTitleFont];
    [aCoder encodeObject:_summary forKey:kVideoContentSummary];
    [aCoder encodeObject:_publishTime forKey:kVideoContentPublishTime];
    [aCoder encodeDouble:_height forKey:kVideoContentHeight];
    [aCoder encodeObject:_app forKey:kVideoContentApp];
}

- (id)copyWithZone:(NSZone *)zone
{
    VideoContent *copy = [[VideoContent alloc] init];
    
    if (copy) {

        copy.contentIdentifier = [self.contentIdentifier copyWithZone:zone];
        copy.videoUrl = [self.videoUrl copyWithZone:zone];
        copy.subtitle = [self.subtitle copyWithZone:zone];
        copy.publishURL = [self.publishURL copyWithZone:zone];
        copy.channel = [self.channel copyWithZone:zone];
        copy.subTitleFont = [self.subTitleFont copyWithZone:zone];
        copy.width = self.width;
        copy.contentType = self.contentType;
        copy.cid = [self.cid copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.updateMd5 = [self.updateMd5 copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.titleFont = [self.titleFont copyWithZone:zone];
        copy.summary = [self.summary copyWithZone:zone];
        copy.publishTime = [self.publishTime copyWithZone:zone];
        copy.height = self.height;
        copy.app = [self.app copyWithZone:zone];
    }
    
    return copy;
}


@end
