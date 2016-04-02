//
//  ContentDEImg.m
//
//  Created by mac  on 16/4/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ContentDEImg.h"


NSString *const kContentDEImgStyle = @"style";
NSString *const kContentDEImgSrc = @"src";


@interface ContentDEImg ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ContentDEImg

@synthesize style = _style;
@synthesize src = _src;


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
            self.style = [self objectOrNilForKey:kContentDEImgStyle fromDictionary:dict];
            self.src = [self objectOrNilForKey:kContentDEImgSrc fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.style forKey:kContentDEImgStyle];
    [mutableDict setValue:self.src forKey:kContentDEImgSrc];

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

    self.style = [aDecoder decodeObjectForKey:kContentDEImgStyle];
    self.src = [aDecoder decodeObjectForKey:kContentDEImgSrc];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_style forKey:kContentDEImgStyle];
    [aCoder encodeObject:_src forKey:kContentDEImgSrc];
}

- (id)copyWithZone:(NSZone *)zone
{
    ContentDEImg *copy = [[ContentDEImg alloc] init];
    
    if (copy) {

        copy.style = [self.style copyWithZone:zone];
        copy.src = [self.src copyWithZone:zone];
    }
    
    return copy;
}


@end
