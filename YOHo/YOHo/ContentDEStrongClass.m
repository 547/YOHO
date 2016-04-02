//
//  ContentDEStrongClass.m
//
//  Created by mac  on 16/4/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ContentDEStrongClass.h"


NSString *const kContentDEStrongClassStyle = @"style";
NSString *const kContentDEStrongClassText = @"text";


@interface ContentDEStrongClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ContentDEStrongClass

@synthesize style = _style;
@synthesize text = _text;


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
            self.style = [self objectOrNilForKey:kContentDEStrongClassStyle fromDictionary:dict];
            self.text = [self objectOrNilForKey:kContentDEStrongClassText fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.style forKey:kContentDEStrongClassStyle];
    [mutableDict setValue:self.text forKey:kContentDEStrongClassText];

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

    self.style = [aDecoder decodeObjectForKey:kContentDEStrongClassStyle];
    self.text = [aDecoder decodeObjectForKey:kContentDEStrongClassText];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_style forKey:kContentDEStrongClassStyle];
    [aCoder encodeObject:_text forKey:kContentDEStrongClassText];
}

- (id)copyWithZone:(NSZone *)zone
{
    ContentDEStrongClass *copy = [[ContentDEStrongClass alloc] init];
    
    if (copy) {

        copy.style = [self.style copyWithZone:zone];
        copy.text = [self.text copyWithZone:zone];
    }
    
    return copy;
}


@end
