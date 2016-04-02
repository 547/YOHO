//
//  VideoData.m
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "VideoData.h"
#import "VideoContent.h"


NSString *const kVideoDataContent = @"content";
NSString *const kVideoDataTotal = @"total";


@interface VideoData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation VideoData

@synthesize content = _content;
@synthesize total = _total;


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
    NSObject *receivedVideoContent = [dict objectForKey:kVideoDataContent];
    NSMutableArray *parsedVideoContent = [NSMutableArray array];
    if ([receivedVideoContent isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedVideoContent) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedVideoContent addObject:[VideoContent modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedVideoContent isKindOfClass:[NSDictionary class]]) {
       [parsedVideoContent addObject:[VideoContent modelObjectWithDictionary:(NSDictionary *)receivedVideoContent]];
    }

    self.content = [NSArray arrayWithArray:parsedVideoContent];
            self.total = [[self objectOrNilForKey:kVideoDataTotal fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForContent = [NSMutableArray array];
    for (NSObject *subArrayObject in self.content) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForContent addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForContent addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForContent] forKey:kVideoDataContent];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kVideoDataTotal];

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

    self.content = [aDecoder decodeObjectForKey:kVideoDataContent];
    self.total = [aDecoder decodeDoubleForKey:kVideoDataTotal];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_content forKey:kVideoDataContent];
    [aCoder encodeDouble:_total forKey:kVideoDataTotal];
}

- (id)copyWithZone:(NSZone *)zone
{
    VideoData *copy = [[VideoData alloc] init];
    
    if (copy) {

        copy.content = [self.content copyWithZone:zone];
        copy.total = self.total;
    }
    
    return copy;
}


@end
