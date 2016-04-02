//
//  WallPapersData.m
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "WallPapersData.h"
#import "WallPapersWallpaperList.h"


NSString *const kWallPapersDataTotal = @"total";
NSString *const kWallPapersDataWallpaperList = @"wallpaperList";


@interface WallPapersData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WallPapersData

@synthesize total = _total;
@synthesize wallpaperList = _wallpaperList;


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
            self.total = [self objectOrNilForKey:kWallPapersDataTotal fromDictionary:dict];
    NSObject *receivedWallPapersWallpaperList = [dict objectForKey:kWallPapersDataWallpaperList];
    NSMutableArray *parsedWallPapersWallpaperList = [NSMutableArray array];
    if ([receivedWallPapersWallpaperList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedWallPapersWallpaperList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedWallPapersWallpaperList addObject:[WallPapersWallpaperList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedWallPapersWallpaperList isKindOfClass:[NSDictionary class]]) {
       [parsedWallPapersWallpaperList addObject:[WallPapersWallpaperList modelObjectWithDictionary:(NSDictionary *)receivedWallPapersWallpaperList]];
    }

    self.wallpaperList = [NSArray arrayWithArray:parsedWallPapersWallpaperList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.total forKey:kWallPapersDataTotal];
    NSMutableArray *tempArrayForWallpaperList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.wallpaperList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForWallpaperList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForWallpaperList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForWallpaperList] forKey:kWallPapersDataWallpaperList];

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

    self.total = [aDecoder decodeObjectForKey:kWallPapersDataTotal];
    self.wallpaperList = [aDecoder decodeObjectForKey:kWallPapersDataWallpaperList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_total forKey:kWallPapersDataTotal];
    [aCoder encodeObject:_wallpaperList forKey:kWallPapersDataWallpaperList];
}

- (id)copyWithZone:(NSZone *)zone
{
    WallPapersData *copy = [[WallPapersData alloc] init];
    
    if (copy) {

        copy.total = [self.total copyWithZone:zone];
        copy.wallpaperList = [self.wallpaperList copyWithZone:zone];
    }
    
    return copy;
}


@end
