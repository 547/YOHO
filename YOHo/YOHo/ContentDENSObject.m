//
//  ContentDENSObject.m
//
//  Created by mac  on 16/4/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ContentDENSObject.h"
#import "ContentDEDiv.h"


NSString *const kContentDENSObjectDiv = @"div";


@interface ContentDENSObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ContentDENSObject

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
            self.div = [ContentDEDiv modelObjectWithDictionary:[dict objectForKey:kContentDENSObjectDiv]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.div dictionaryRepresentation] forKey:kContentDENSObjectDiv];

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

    self.div = [aDecoder decodeObjectForKey:kContentDENSObjectDiv];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_div forKey:kContentDENSObjectDiv];
}

- (id)copyWithZone:(NSZone *)zone
{
    ContentDENSObject *copy = [[ContentDENSObject alloc] init];
    
    if (copy) {

        copy.div = [self.div copyWithZone:zone];
    }
    
    return copy;
}


@end
