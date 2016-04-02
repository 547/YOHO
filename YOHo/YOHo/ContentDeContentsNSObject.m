//
//  ContentDeContentsNSObject.m
//
//  Created by mac  on 16/4/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ContentDeContentsNSObject.h"
#import "ContentDeContentsDiv.h"


NSString *const kContentDeContentsNSObjectDiv = @"div";


@interface ContentDeContentsNSObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ContentDeContentsNSObject

@synthesize div = _div;


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
            self.div = [ContentDeContentsDiv modelObjectWithDictionary:[dict objectForKey:kContentDeContentsNSObjectDiv]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.div dictionaryRepresentation] forKey:kContentDeContentsNSObjectDiv];

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

    self.div = [aDecoder decodeObjectForKey:kContentDeContentsNSObjectDiv];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_div forKey:kContentDeContentsNSObjectDiv];
}

- (id)copyWithZone:(NSZone *)zone
{
    ContentDeContentsNSObject *copy = [[ContentDeContentsNSObject alloc] init];
    
    if (copy) {

        copy.div = [self.div copyWithZone:zone];
    }
    
    return copy;
}


@end
