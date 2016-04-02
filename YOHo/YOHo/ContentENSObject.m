//
//  ContentENSObject.m
//
//  Created by mac  on 16/4/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ContentENSObject.h"
#import "ContentEData.h"


NSString *const kContentENSObjectStatus = @"status";
NSString *const kContentENSObjectData = @"data";
NSString *const kContentENSObjectCode = @"code";
NSString *const kContentENSObjectMessage = @"message";


@interface ContentENSObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ContentENSObject

@synthesize status = _status;
@synthesize data = _data;
@synthesize code = _code;
@synthesize message = _message;


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
            self.status = [self objectOrNilForKey:kContentENSObjectStatus fromDictionary:dict];
            self.data = [ContentEData modelObjectWithDictionary:[dict objectForKey:kContentENSObjectData]];
            self.code = [[self objectOrNilForKey:kContentENSObjectCode fromDictionary:dict] doubleValue];
            self.message = [self objectOrNilForKey:kContentENSObjectMessage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kContentENSObjectStatus];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kContentENSObjectData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kContentENSObjectCode];
    [mutableDict setValue:self.message forKey:kContentENSObjectMessage];

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

    self.status = [aDecoder decodeObjectForKey:kContentENSObjectStatus];
    self.data = [aDecoder decodeObjectForKey:kContentENSObjectData];
    self.code = [aDecoder decodeDoubleForKey:kContentENSObjectCode];
    self.message = [aDecoder decodeObjectForKey:kContentENSObjectMessage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kContentENSObjectStatus];
    [aCoder encodeObject:_data forKey:kContentENSObjectData];
    [aCoder encodeDouble:_code forKey:kContentENSObjectCode];
    [aCoder encodeObject:_message forKey:kContentENSObjectMessage];
}

- (id)copyWithZone:(NSZone *)zone
{
    ContentENSObject *copy = [[ContentENSObject alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
        copy.message = [self.message copyWithZone:zone];
    }
    
    return copy;
}


@end
