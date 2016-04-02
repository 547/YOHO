//
//  WallPapersWallpaperList.m
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "WallPapersWallpaperList.h"
#import "WallPapersImages.h"


NSString *const kWallPapersWallpaperListJournal = @"journal";
NSString *const kWallPapersWallpaperListYear = @"year";
NSString *const kWallPapersWallpaperListMonth = @"month";
NSString *const kWallPapersWallpaperListImages = @"images";


@interface WallPapersWallpaperList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WallPapersWallpaperList

@synthesize journal = _journal;
@synthesize year = _year;
@synthesize month = _month;
@synthesize images = _images;


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
            self.journal = [self objectOrNilForKey:kWallPapersWallpaperListJournal fromDictionary:dict];
            self.year = [self objectOrNilForKey:kWallPapersWallpaperListYear fromDictionary:dict];
            self.month = [self objectOrNilForKey:kWallPapersWallpaperListMonth fromDictionary:dict];
    NSObject *receivedWallPapersImages = [dict objectForKey:kWallPapersWallpaperListImages];
    NSMutableArray *parsedWallPapersImages = [NSMutableArray array];
    if ([receivedWallPapersImages isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedWallPapersImages) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedWallPapersImages addObject:[WallPapersImages modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedWallPapersImages isKindOfClass:[NSDictionary class]]) {
       [parsedWallPapersImages addObject:[WallPapersImages modelObjectWithDictionary:(NSDictionary *)receivedWallPapersImages]];
    }

    self.images = [NSArray arrayWithArray:parsedWallPapersImages];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.journal forKey:kWallPapersWallpaperListJournal];
    [mutableDict setValue:self.year forKey:kWallPapersWallpaperListYear];
    [mutableDict setValue:self.month forKey:kWallPapersWallpaperListMonth];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImages] forKey:kWallPapersWallpaperListImages];

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

    self.journal = [aDecoder decodeObjectForKey:kWallPapersWallpaperListJournal];
    self.year = [aDecoder decodeObjectForKey:kWallPapersWallpaperListYear];
    self.month = [aDecoder decodeObjectForKey:kWallPapersWallpaperListMonth];
    self.images = [aDecoder decodeObjectForKey:kWallPapersWallpaperListImages];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_journal forKey:kWallPapersWallpaperListJournal];
    [aCoder encodeObject:_year forKey:kWallPapersWallpaperListYear];
    [aCoder encodeObject:_month forKey:kWallPapersWallpaperListMonth];
    [aCoder encodeObject:_images forKey:kWallPapersWallpaperListImages];
}

- (id)copyWithZone:(NSZone *)zone
{
    WallPapersWallpaperList *copy = [[WallPapersWallpaperList alloc] init];
    
    if (copy) {

        copy.journal = [self.journal copyWithZone:zone];
        copy.year = [self.year copyWithZone:zone];
        copy.month = [self.month copyWithZone:zone];
        copy.images = [self.images copyWithZone:zone];
    }
    
    return copy;
}


@end
