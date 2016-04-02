//
//  ContentDEBr.m
//
//  Created by mac  on 16/4/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ContentDEBr.h"


NSString *const kContentDEBrText = @"text";


@interface ContentDEBr ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ContentDEBr

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
            self.text = [self objectOrNilForKey:kContentDEBrText fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.text forKey:kContentDEBrText];

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

    self.text = [aDecoder decodeObjectForKey:kContentDEBrText];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_text forKey:kContentDEBrText];
}

- (id)copyWithZone:(NSZone *)zone
{
    ContentDEBr *copy = [[ContentDEBr alloc] init];
    
    if (copy) {

        copy.text = [self.text copyWithZone:zone];
    }
    
    return copy;
}


@end
