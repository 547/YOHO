//
//  SearchFWResult.m
//
//  Created by mac  on 16/4/8
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "SearchFWResult.h"


NSString *const kSearchFWResultStatus = @"status";
NSString *const kSearchFWResultData = @"data";
NSString *const kSearchFWResultCode = @"code";
NSString *const kSearchFWResultMessage = @"message";


@interface SearchFWResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SearchFWResult

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
            self.status = [self objectOrNilForKey:kSearchFWResultStatus fromDictionary:dict];
            self.data = [self objectOrNilForKey:kSearchFWResultData fromDictionary:dict];
            self.code = [[self objectOrNilForKey:kSearchFWResultCode fromDictionary:dict] doubleValue];
            self.message = [self objectOrNilForKey:kSearchFWResultMessage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kSearchFWResultStatus];
    NSMutableArray *tempArrayForData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.data) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kSearchFWResultData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kSearchFWResultCode];
    [mutableDict setValue:self.message forKey:kSearchFWResultMessage];

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

    self.status = [aDecoder decodeObjectForKey:kSearchFWResultStatus];
    self.data = [aDecoder decodeObjectForKey:kSearchFWResultData];
    self.code = [aDecoder decodeDoubleForKey:kSearchFWResultCode];
    self.message = [aDecoder decodeObjectForKey:kSearchFWResultMessage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kSearchFWResultStatus];
    [aCoder encodeObject:_data forKey:kSearchFWResultData];
    [aCoder encodeDouble:_code forKey:kSearchFWResultCode];
    [aCoder encodeObject:_message forKey:kSearchFWResultMessage];
}

- (id)copyWithZone:(NSZone *)zone
{
    SearchFWResult *copy = [[SearchFWResult alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
        copy.message = [self.message copyWithZone:zone];
    }
    
    return copy;
}


@end
