//
//  ContentDESpan.m
//
//  Created by mac  on 16/4/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ContentDESpan.h"
#import "ContentDEStrongClass.h"


NSString *const kContentDESpanStyle = @"style";
NSString *const kContentDESpanStrong = @"strong";


@interface ContentDESpan ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ContentDESpan

@synthesize style = _style;
@synthesize strongProperty = _strongProperty;


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
            self.style = [self objectOrNilForKey:kContentDESpanStyle fromDictionary:dict];
            self.strongProperty = [ContentDEStrongClass modelObjectWithDictionary:[dict objectForKey:kContentDESpanStrong]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.style forKey:kContentDESpanStyle];
    [mutableDict setValue:[self.strongProperty dictionaryRepresentation] forKey:kContentDESpanStrong];

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

    self.style = [aDecoder decodeObjectForKey:kContentDESpanStyle];
    self.strongProperty = [aDecoder decodeObjectForKey:kContentDESpanStrong];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_style forKey:kContentDESpanStyle];
    [aCoder encodeObject:_strongProperty forKey:kContentDESpanStrong];
}

- (id)copyWithZone:(NSZone *)zone
{
    ContentDESpan *copy = [[ContentDESpan alloc] init];
    
    if (copy) {

        copy.style = [self.style copyWithZone:zone];
        copy.strongProperty = [self.strongProperty copyWithZone:zone];
    }
    
    return copy;
}


@end
