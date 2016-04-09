//
//  SearchTWResult.m
//
//  Created by mac  on 16/4/8
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "SearchTWResult.h"
#import "SearchTWData.h"


NSString *const kSearchTWResultStatus = @"status";
NSString *const kSearchTWResultData = @"data";
NSString *const kSearchTWResultCode = @"code";
NSString *const kSearchTWResultMessage = @"message";


@interface SearchTWResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SearchTWResult

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
            self.status = [self objectOrNilForKey:kSearchTWResultStatus fromDictionary:dict];
            self.data = [SearchTWData modelObjectWithDictionary:[dict objectForKey:kSearchTWResultData]];
            self.code = [[self objectOrNilForKey:kSearchTWResultCode fromDictionary:dict] doubleValue];
            self.message = [self objectOrNilForKey:kSearchTWResultMessage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kSearchTWResultStatus];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kSearchTWResultData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kSearchTWResultCode];
    [mutableDict setValue:self.message forKey:kSearchTWResultMessage];

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

    self.status = [aDecoder decodeObjectForKey:kSearchTWResultStatus];
    self.data = [aDecoder decodeObjectForKey:kSearchTWResultData];
    self.code = [aDecoder decodeDoubleForKey:kSearchTWResultCode];
    self.message = [aDecoder decodeObjectForKey:kSearchTWResultMessage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kSearchTWResultStatus];
    [aCoder encodeObject:_data forKey:kSearchTWResultData];
    [aCoder encodeDouble:_code forKey:kSearchTWResultCode];
    [aCoder encodeObject:_message forKey:kSearchTWResultMessage];
}

- (id)copyWithZone:(NSZone *)zone
{
    SearchTWResult *copy = [[SearchTWResult alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
        copy.message = [self.message copyWithZone:zone];
    }
    
    return copy;
}


@end
