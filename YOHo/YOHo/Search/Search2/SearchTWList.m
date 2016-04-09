//
//  SearchTWList.m
//
//  Created by mac  on 16/4/8
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "SearchTWList.h"
#import "SearchTWChannel.h"


NSString *const kSearchTWListId = @"id";
NSString *const kSearchTWListVideoUrl = @"videoUrl";
NSString *const kSearchTWListSubtitle = @"subtitle";
NSString *const kSearchTWListPublishURL = @"publishURL";
NSString *const kSearchTWListChannel = @"channel";
NSString *const kSearchTWListSubTitleFont = @"subTitleFont";
NSString *const kSearchTWListWidth = @"width";
NSString *const kSearchTWListContentType = @"contentType";
NSString *const kSearchTWListCid = @"cid";
NSString *const kSearchTWListTitle = @"title";
NSString *const kSearchTWListUpdateMd5 = @"updateMd5";
NSString *const kSearchTWListTitleFont = @"titleFont";
NSString *const kSearchTWListImage = @"image";
NSString *const kSearchTWListSummary = @"summary";
NSString *const kSearchTWListPublishTime = @"publishTime";
NSString *const kSearchTWListHeight = @"height";
NSString *const kSearchTWListApp = @"app";


@interface SearchTWList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SearchTWList

@synthesize listIdentifier = _listIdentifier;
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
@synthesize titleFont = _titleFont;
@synthesize image = _image;
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
            self.listIdentifier = [self objectOrNilForKey:kSearchTWListId fromDictionary:dict];
            self.videoUrl = [self objectOrNilForKey:kSearchTWListVideoUrl fromDictionary:dict];
            self.subtitle = [self objectOrNilForKey:kSearchTWListSubtitle fromDictionary:dict];
            self.publishURL = [self objectOrNilForKey:kSearchTWListPublishURL fromDictionary:dict];
            self.channel = [SearchTWChannel modelObjectWithDictionary:[dict objectForKey:kSearchTWListChannel]];
            self.subTitleFont = [self objectOrNilForKey:kSearchTWListSubTitleFont fromDictionary:dict];
            self.width = [[self objectOrNilForKey:kSearchTWListWidth fromDictionary:dict] doubleValue];
            self.contentType = [[self objectOrNilForKey:kSearchTWListContentType fromDictionary:dict] doubleValue];
            self.cid = [self objectOrNilForKey:kSearchTWListCid fromDictionary:dict];
            self.title = [self objectOrNilForKey:kSearchTWListTitle fromDictionary:dict];
            self.updateMd5 = [self objectOrNilForKey:kSearchTWListUpdateMd5 fromDictionary:dict];
            self.titleFont = [self objectOrNilForKey:kSearchTWListTitleFont fromDictionary:dict];
            self.image = [self objectOrNilForKey:kSearchTWListImage fromDictionary:dict];
            self.summary = [self objectOrNilForKey:kSearchTWListSummary fromDictionary:dict];
            self.publishTime = [self objectOrNilForKey:kSearchTWListPublishTime fromDictionary:dict];
            self.height = [[self objectOrNilForKey:kSearchTWListHeight fromDictionary:dict] doubleValue];
            self.app = [[self objectOrNilForKey:kSearchTWListApp fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.listIdentifier forKey:kSearchTWListId];
    [mutableDict setValue:self.videoUrl forKey:kSearchTWListVideoUrl];
    [mutableDict setValue:self.subtitle forKey:kSearchTWListSubtitle];
    [mutableDict setValue:self.publishURL forKey:kSearchTWListPublishURL];
    [mutableDict setValue:[self.channel dictionaryRepresentation] forKey:kSearchTWListChannel];
    [mutableDict setValue:self.subTitleFont forKey:kSearchTWListSubTitleFont];
    [mutableDict setValue:[NSNumber numberWithDouble:self.width] forKey:kSearchTWListWidth];
    [mutableDict setValue:[NSNumber numberWithDouble:self.contentType] forKey:kSearchTWListContentType];
    [mutableDict setValue:self.cid forKey:kSearchTWListCid];
    [mutableDict setValue:self.title forKey:kSearchTWListTitle];
    [mutableDict setValue:self.updateMd5 forKey:kSearchTWListUpdateMd5];
    [mutableDict setValue:self.titleFont forKey:kSearchTWListTitleFont];
    [mutableDict setValue:self.image forKey:kSearchTWListImage];
    [mutableDict setValue:self.summary forKey:kSearchTWListSummary];
    [mutableDict setValue:self.publishTime forKey:kSearchTWListPublishTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.height] forKey:kSearchTWListHeight];
    [mutableDict setValue:[NSNumber numberWithDouble:self.app] forKey:kSearchTWListApp];

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

    self.listIdentifier = [aDecoder decodeObjectForKey:kSearchTWListId];
    self.videoUrl = [aDecoder decodeObjectForKey:kSearchTWListVideoUrl];
    self.subtitle = [aDecoder decodeObjectForKey:kSearchTWListSubtitle];
    self.publishURL = [aDecoder decodeObjectForKey:kSearchTWListPublishURL];
    self.channel = [aDecoder decodeObjectForKey:kSearchTWListChannel];
    self.subTitleFont = [aDecoder decodeObjectForKey:kSearchTWListSubTitleFont];
    self.width = [aDecoder decodeDoubleForKey:kSearchTWListWidth];
    self.contentType = [aDecoder decodeDoubleForKey:kSearchTWListContentType];
    self.cid = [aDecoder decodeObjectForKey:kSearchTWListCid];
    self.title = [aDecoder decodeObjectForKey:kSearchTWListTitle];
    self.updateMd5 = [aDecoder decodeObjectForKey:kSearchTWListUpdateMd5];
    self.titleFont = [aDecoder decodeObjectForKey:kSearchTWListTitleFont];
    self.image = [aDecoder decodeObjectForKey:kSearchTWListImage];
    self.summary = [aDecoder decodeObjectForKey:kSearchTWListSummary];
    self.publishTime = [aDecoder decodeObjectForKey:kSearchTWListPublishTime];
    self.height = [aDecoder decodeDoubleForKey:kSearchTWListHeight];
    self.app = [aDecoder decodeDoubleForKey:kSearchTWListApp];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_listIdentifier forKey:kSearchTWListId];
    [aCoder encodeObject:_videoUrl forKey:kSearchTWListVideoUrl];
    [aCoder encodeObject:_subtitle forKey:kSearchTWListSubtitle];
    [aCoder encodeObject:_publishURL forKey:kSearchTWListPublishURL];
    [aCoder encodeObject:_channel forKey:kSearchTWListChannel];
    [aCoder encodeObject:_subTitleFont forKey:kSearchTWListSubTitleFont];
    [aCoder encodeDouble:_width forKey:kSearchTWListWidth];
    [aCoder encodeDouble:_contentType forKey:kSearchTWListContentType];
    [aCoder encodeObject:_cid forKey:kSearchTWListCid];
    [aCoder encodeObject:_title forKey:kSearchTWListTitle];
    [aCoder encodeObject:_updateMd5 forKey:kSearchTWListUpdateMd5];
    [aCoder encodeObject:_titleFont forKey:kSearchTWListTitleFont];
    [aCoder encodeObject:_image forKey:kSearchTWListImage];
    [aCoder encodeObject:_summary forKey:kSearchTWListSummary];
    [aCoder encodeObject:_publishTime forKey:kSearchTWListPublishTime];
    [aCoder encodeDouble:_height forKey:kSearchTWListHeight];
    [aCoder encodeDouble:_app forKey:kSearchTWListApp];
}

- (id)copyWithZone:(NSZone *)zone
{
    SearchTWList *copy = [[SearchTWList alloc] init];
    
    if (copy) {

        copy.listIdentifier = [self.listIdentifier copyWithZone:zone];
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
        copy.titleFont = [self.titleFont copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.summary = [self.summary copyWithZone:zone];
        copy.publishTime = [self.publishTime copyWithZone:zone];
        copy.height = self.height;
        copy.app = self.app;
    }
    
    return copy;
}


@end
