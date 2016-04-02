//
//  ContentEContents.m
//
//  Created by mac  on 16/4/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ContentEContents.h"
#import "ContentEImages.h"


NSString *const kContentEContentsUpdateMd5 = @"updateMd5";
NSString *const kContentEContentsContent = @"content";
NSString *const kContentEContentsGps = @"gps";
NSString *const kContentEContentsTotal = @"total";
NSString *const kContentEContentsTitle = @"title";
NSString *const kContentEContentsSummary = @"summary";
NSString *const kContentEContentsImages = @"images";
NSString *const kContentEContentsType = @"type";
NSString *const kContentEContentsCid = @"cid";
NSString *const kContentEContentsId = @"id";
NSString *const kContentEContentsSubtitle = @"subtitle";
NSString *const kContentEContentsContentType = @"contentType";
NSString *const kContentEContentsHeight = @"height";
NSString *const kContentEContentsWidth = @"width";
NSString *const kContentEContentsPublishTime = @"publishTime";
NSString *const kContentEContentsTitleFont = @"titleFont";
NSString *const kContentEContentsEditor = @"editor";
NSString *const kContentEContentsPublishURL = @"publishURL";
NSString *const kContentEContentsSubTitleFont = @"subTitleFont";
NSString *const kContentEContentsApp = @"app";
NSString *const kContentEContentsAddress = @"address";


@interface ContentEContents ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ContentEContents

@synthesize updateMd5 = _updateMd5;
@synthesize content = _content;
@synthesize gps = _gps;
@synthesize total = _total;
@synthesize title = _title;
@synthesize summary = _summary;
@synthesize images = _images;
@synthesize type = _type;
@synthesize cid = _cid;
@synthesize contentsIdentifier = _contentsIdentifier;
@synthesize subtitle = _subtitle;
@synthesize contentType = _contentType;
@synthesize height = _height;
@synthesize width = _width;
@synthesize publishTime = _publishTime;
@synthesize titleFont = _titleFont;
@synthesize editor = _editor;
@synthesize publishURL = _publishURL;
@synthesize subTitleFont = _subTitleFont;
@synthesize app = _app;
@synthesize address = _address;


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
            self.updateMd5 = [self objectOrNilForKey:kContentEContentsUpdateMd5 fromDictionary:dict];
            self.content = [self objectOrNilForKey:kContentEContentsContent fromDictionary:dict];
            self.gps = [self objectOrNilForKey:kContentEContentsGps fromDictionary:dict];
            self.total = [self objectOrNilForKey:kContentEContentsTotal fromDictionary:dict];
            self.title = [self objectOrNilForKey:kContentEContentsTitle fromDictionary:dict];
            self.summary = [self objectOrNilForKey:kContentEContentsSummary fromDictionary:dict];
    NSObject *receivedContentEImages = [dict objectForKey:kContentEContentsImages];
    NSMutableArray *parsedContentEImages = [NSMutableArray array];
    if ([receivedContentEImages isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedContentEImages) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedContentEImages addObject:[ContentEImages modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedContentEImages isKindOfClass:[NSDictionary class]]) {
       [parsedContentEImages addObject:[ContentEImages modelObjectWithDictionary:(NSDictionary *)receivedContentEImages]];
    }

    self.images = [NSArray arrayWithArray:parsedContentEImages];
            self.type = [self objectOrNilForKey:kContentEContentsType fromDictionary:dict];
            self.cid = [self objectOrNilForKey:kContentEContentsCid fromDictionary:dict];
            self.contentsIdentifier = [self objectOrNilForKey:kContentEContentsId fromDictionary:dict];
            self.subtitle = [self objectOrNilForKey:kContentEContentsSubtitle fromDictionary:dict];
            self.contentType = [[self objectOrNilForKey:kContentEContentsContentType fromDictionary:dict] doubleValue];
            self.height = [[self objectOrNilForKey:kContentEContentsHeight fromDictionary:dict] doubleValue];
            self.width = [[self objectOrNilForKey:kContentEContentsWidth fromDictionary:dict] doubleValue];
            self.publishTime = [self objectOrNilForKey:kContentEContentsPublishTime fromDictionary:dict];
            self.titleFont = [self objectOrNilForKey:kContentEContentsTitleFont fromDictionary:dict];
            self.editor = [self objectOrNilForKey:kContentEContentsEditor fromDictionary:dict];
            self.publishURL = [self objectOrNilForKey:kContentEContentsPublishURL fromDictionary:dict];
            self.subTitleFont = [self objectOrNilForKey:kContentEContentsSubTitleFont fromDictionary:dict];
            self.app = [[self objectOrNilForKey:kContentEContentsApp fromDictionary:dict] doubleValue];
            self.address = [self objectOrNilForKey:kContentEContentsAddress fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.updateMd5 forKey:kContentEContentsUpdateMd5];
    [mutableDict setValue:self.content forKey:kContentEContentsContent];
    [mutableDict setValue:self.gps forKey:kContentEContentsGps];
    [mutableDict setValue:self.total forKey:kContentEContentsTotal];
    [mutableDict setValue:self.title forKey:kContentEContentsTitle];
    [mutableDict setValue:self.summary forKey:kContentEContentsSummary];
    NSMutableArray *tempArrayForImages = [NSMutableArray array];
    for (NSObject *subArrayObject in self.images) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForImages addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForImages addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImages] forKey:kContentEContentsImages];
    [mutableDict setValue:self.type forKey:kContentEContentsType];
    [mutableDict setValue:self.cid forKey:kContentEContentsCid];
    [mutableDict setValue:self.contentsIdentifier forKey:kContentEContentsId];
    [mutableDict setValue:self.subtitle forKey:kContentEContentsSubtitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.contentType] forKey:kContentEContentsContentType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.height] forKey:kContentEContentsHeight];
    [mutableDict setValue:[NSNumber numberWithDouble:self.width] forKey:kContentEContentsWidth];
    [mutableDict setValue:self.publishTime forKey:kContentEContentsPublishTime];
    [mutableDict setValue:self.titleFont forKey:kContentEContentsTitleFont];
    NSMutableArray *tempArrayForEditor = [NSMutableArray array];
    for (NSObject *subArrayObject in self.editor) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForEditor addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForEditor addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForEditor] forKey:kContentEContentsEditor];
    [mutableDict setValue:self.publishURL forKey:kContentEContentsPublishURL];
    [mutableDict setValue:self.subTitleFont forKey:kContentEContentsSubTitleFont];
    [mutableDict setValue:[NSNumber numberWithDouble:self.app] forKey:kContentEContentsApp];
    [mutableDict setValue:self.address forKey:kContentEContentsAddress];

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

    self.updateMd5 = [aDecoder decodeObjectForKey:kContentEContentsUpdateMd5];
    self.content = [aDecoder decodeObjectForKey:kContentEContentsContent];
    self.gps = [aDecoder decodeObjectForKey:kContentEContentsGps];
    self.total = [aDecoder decodeObjectForKey:kContentEContentsTotal];
    self.title = [aDecoder decodeObjectForKey:kContentEContentsTitle];
    self.summary = [aDecoder decodeObjectForKey:kContentEContentsSummary];
    self.images = [aDecoder decodeObjectForKey:kContentEContentsImages];
    self.type = [aDecoder decodeObjectForKey:kContentEContentsType];
    self.cid = [aDecoder decodeObjectForKey:kContentEContentsCid];
    self.contentsIdentifier = [aDecoder decodeObjectForKey:kContentEContentsId];
    self.subtitle = [aDecoder decodeObjectForKey:kContentEContentsSubtitle];
    self.contentType = [aDecoder decodeDoubleForKey:kContentEContentsContentType];
    self.height = [aDecoder decodeDoubleForKey:kContentEContentsHeight];
    self.width = [aDecoder decodeDoubleForKey:kContentEContentsWidth];
    self.publishTime = [aDecoder decodeObjectForKey:kContentEContentsPublishTime];
    self.titleFont = [aDecoder decodeObjectForKey:kContentEContentsTitleFont];
    self.editor = [aDecoder decodeObjectForKey:kContentEContentsEditor];
    self.publishURL = [aDecoder decodeObjectForKey:kContentEContentsPublishURL];
    self.subTitleFont = [aDecoder decodeObjectForKey:kContentEContentsSubTitleFont];
    self.app = [aDecoder decodeDoubleForKey:kContentEContentsApp];
    self.address = [aDecoder decodeObjectForKey:kContentEContentsAddress];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_updateMd5 forKey:kContentEContentsUpdateMd5];
    [aCoder encodeObject:_content forKey:kContentEContentsContent];
    [aCoder encodeObject:_gps forKey:kContentEContentsGps];
    [aCoder encodeObject:_total forKey:kContentEContentsTotal];
    [aCoder encodeObject:_title forKey:kContentEContentsTitle];
    [aCoder encodeObject:_summary forKey:kContentEContentsSummary];
    [aCoder encodeObject:_images forKey:kContentEContentsImages];
    [aCoder encodeObject:_type forKey:kContentEContentsType];
    [aCoder encodeObject:_cid forKey:kContentEContentsCid];
    [aCoder encodeObject:_contentsIdentifier forKey:kContentEContentsId];
    [aCoder encodeObject:_subtitle forKey:kContentEContentsSubtitle];
    [aCoder encodeDouble:_contentType forKey:kContentEContentsContentType];
    [aCoder encodeDouble:_height forKey:kContentEContentsHeight];
    [aCoder encodeDouble:_width forKey:kContentEContentsWidth];
    [aCoder encodeObject:_publishTime forKey:kContentEContentsPublishTime];
    [aCoder encodeObject:_titleFont forKey:kContentEContentsTitleFont];
    [aCoder encodeObject:_editor forKey:kContentEContentsEditor];
    [aCoder encodeObject:_publishURL forKey:kContentEContentsPublishURL];
    [aCoder encodeObject:_subTitleFont forKey:kContentEContentsSubTitleFont];
    [aCoder encodeDouble:_app forKey:kContentEContentsApp];
    [aCoder encodeObject:_address forKey:kContentEContentsAddress];
}

- (id)copyWithZone:(NSZone *)zone
{
    ContentEContents *copy = [[ContentEContents alloc] init];
    
    if (copy) {

        copy.updateMd5 = [self.updateMd5 copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
        copy.gps = [self.gps copyWithZone:zone];
        copy.total = [self.total copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.summary = [self.summary copyWithZone:zone];
        copy.images = [self.images copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.cid = [self.cid copyWithZone:zone];
        copy.contentsIdentifier = [self.contentsIdentifier copyWithZone:zone];
        copy.subtitle = [self.subtitle copyWithZone:zone];
        copy.contentType = self.contentType;
        copy.height = self.height;
        copy.width = self.width;
        copy.publishTime = [self.publishTime copyWithZone:zone];
        copy.titleFont = [self.titleFont copyWithZone:zone];
        copy.editor = [self.editor copyWithZone:zone];
        copy.publishURL = [self.publishURL copyWithZone:zone];
        copy.subTitleFont = [self.subTitleFont copyWithZone:zone];
        copy.app = self.app;
        copy.address = [self.address copyWithZone:zone];
    }
    
    return copy;
}


@end
