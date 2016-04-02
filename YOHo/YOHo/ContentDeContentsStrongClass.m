//
//  ContentDeContentsStrongClass.m
//
//  Created by mac  on 16/4/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ContentDeContentsStrongClass.h"
#import "ContentDeContentsSpan.h"


NSString *const kContentDeContentsStrongClassStyle = @"style";
NSString *const kContentDeContentsStrongClassSpan = @"span";


@interface ContentDeContentsStrongClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ContentDeContentsStrongClass

@synthesize style = _style;
@synthesize span = _span;


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
            self.style = [self objectOrNilForKey:kContentDeContentsStrongClassStyle fromDictionary:dict];
            self.span = [ContentDeContentsSpan modelObjectWithDictionary:[dict objectForKey:kContentDeContentsStrongClassSpan]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.style forKey:kContentDeContentsStrongClassStyle];
    [mutableDict setValue:[self.span dictionaryRepresentation] forKey:kContentDeContentsStrongClassSpan];

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

    self.style = [aDecoder decodeObjectForKey:kContentDeContentsStrongClassStyle];
    self.span = [aDecoder decodeObjectForKey:kContentDeContentsStrongClassSpan];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_style forKey:kContentDeContentsStrongClassStyle];
    [aCoder encodeObject:_span forKey:kContentDeContentsStrongClassSpan];
}

- (id)copyWithZone:(NSZone *)zone
{
    ContentDeContentsStrongClass *copy = [[ContentDeContentsStrongClass alloc] init];
    
    if (copy) {

        copy.style = [self.style copyWithZone:zone];
        copy.span = [self.span copyWithZone:zone];
    }
    
    return copy;
}


@end
