//
//  ContentDeContentsImg.m
//
//  Created by mac  on 16/4/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ContentDeContentsImg.h"


NSString *const kContentDeContentsImgStyle = @"style";
NSString *const kContentDeContentsImgSrc = @"src";


@interface ContentDeContentsImg ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ContentDeContentsImg

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
            self.style = [self objectOrNilForKey:kContentDeContentsImgStyle fromDictionary:dict];
            self.src = [self objectOrNilForKey:kContentDeContentsImgSrc fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.style forKey:kContentDeContentsImgStyle];
    [mutableDict setValue:self.src forKey:kContentDeContentsImgSrc];

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

    self.style = [aDecoder decodeObjectForKey:kContentDeContentsImgStyle];
    self.src = [aDecoder decodeObjectForKey:kContentDeContentsImgSrc];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_style forKey:kContentDeContentsImgStyle];
    [aCoder encodeObject:_src forKey:kContentDeContentsImgSrc];
}

- (id)copyWithZone:(NSZone *)zone
{
    ContentDeContentsImg *copy = [[ContentDeContentsImg alloc] init];
    
    if (copy) {

        copy.style = [self.style copyWithZone:zone];
        copy.src = [self.src copyWithZone:zone];
    }
    
    return copy;
}


@end
