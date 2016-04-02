//
//  ContentEImages.m
//
//  Created by mac  on 16/4/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ContentEImages.h"


NSString *const kContentEImagesUrl = @"url";
NSString *const kContentEImagesType = @"type";


@interface ContentEImages ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ContentEImages

@synthesize url = _url;
@synthesize type = _type;


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
            self.url = [self objectOrNilForKey:kContentEImagesUrl fromDictionary:dict];
            self.type = [[self objectOrNilForKey:kContentEImagesType fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.url forKey:kContentEImagesUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kContentEImagesType];

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

    self.url = [aDecoder decodeObjectForKey:kContentEImagesUrl];
    self.type = [aDecoder decodeDoubleForKey:kContentEImagesType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_url forKey:kContentEImagesUrl];
    [aCoder encodeDouble:_type forKey:kContentEImagesType];
}

- (id)copyWithZone:(NSZone *)zone
{
    ContentEImages *copy = [[ContentEImages alloc] init];
    
    if (copy) {

        copy.url = [self.url copyWithZone:zone];
        copy.type = self.type;
    }
    
    return copy;
}


@end
