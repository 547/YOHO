//
//  WallPapersImages.m
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "WallPapersImages.h"


NSString *const kWallPapersImagesApp = @"app";
NSString *const kWallPapersImagesId = @"id";
NSString *const kWallPapersImagesTitle = @"title";
NSString *const kWallPapersImagesSourceImage = @"sourceImage";
NSString *const kWallPapersImagesThumbImage = @"thumbImage";
NSString *const kWallPapersImagesShareUrl = @"shareUrl";


@interface WallPapersImages ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WallPapersImages

@synthesize app = _app;
@synthesize imagesIdentifier = _imagesIdentifier;
@synthesize title = _title;
@synthesize sourceImage = _sourceImage;
@synthesize thumbImage = _thumbImage;
@synthesize shareUrl = _shareUrl;


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
            self.app = [self objectOrNilForKey:kWallPapersImagesApp fromDictionary:dict];
            self.imagesIdentifier = [self objectOrNilForKey:kWallPapersImagesId fromDictionary:dict];
            self.title = [self objectOrNilForKey:kWallPapersImagesTitle fromDictionary:dict];
            self.sourceImage = [self objectOrNilForKey:kWallPapersImagesSourceImage fromDictionary:dict];
            self.thumbImage = [self objectOrNilForKey:kWallPapersImagesThumbImage fromDictionary:dict];
            self.shareUrl = [self objectOrNilForKey:kWallPapersImagesShareUrl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.app forKey:kWallPapersImagesApp];
    [mutableDict setValue:self.imagesIdentifier forKey:kWallPapersImagesId];
    [mutableDict setValue:self.title forKey:kWallPapersImagesTitle];
    [mutableDict setValue:self.sourceImage forKey:kWallPapersImagesSourceImage];
    [mutableDict setValue:self.thumbImage forKey:kWallPapersImagesThumbImage];
    [mutableDict setValue:self.shareUrl forKey:kWallPapersImagesShareUrl];

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

    self.app = [aDecoder decodeObjectForKey:kWallPapersImagesApp];
    self.imagesIdentifier = [aDecoder decodeObjectForKey:kWallPapersImagesId];
    self.title = [aDecoder decodeObjectForKey:kWallPapersImagesTitle];
    self.sourceImage = [aDecoder decodeObjectForKey:kWallPapersImagesSourceImage];
    self.thumbImage = [aDecoder decodeObjectForKey:kWallPapersImagesThumbImage];
    self.shareUrl = [aDecoder decodeObjectForKey:kWallPapersImagesShareUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_app forKey:kWallPapersImagesApp];
    [aCoder encodeObject:_imagesIdentifier forKey:kWallPapersImagesId];
    [aCoder encodeObject:_title forKey:kWallPapersImagesTitle];
    [aCoder encodeObject:_sourceImage forKey:kWallPapersImagesSourceImage];
    [aCoder encodeObject:_thumbImage forKey:kWallPapersImagesThumbImage];
    [aCoder encodeObject:_shareUrl forKey:kWallPapersImagesShareUrl];
}

- (id)copyWithZone:(NSZone *)zone
{
    WallPapersImages *copy = [[WallPapersImages alloc] init];
    
    if (copy) {

        copy.app = [self.app copyWithZone:zone];
        copy.imagesIdentifier = [self.imagesIdentifier copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.sourceImage = [self.sourceImage copyWithZone:zone];
        copy.thumbImage = [self.thumbImage copyWithZone:zone];
        copy.shareUrl = [self.shareUrl copyWithZone:zone];
    }
    
    return copy;
}


@end
