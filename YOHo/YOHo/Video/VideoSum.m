//
//  VideoSum.m
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "VideoSum.h"
#import "VideoData.h"


NSString *const kVideoSumStatus = @"status";
NSString *const kVideoSumData = @"data";
NSString *const kVideoSumCode = @"code";
NSString *const kVideoSumMessage = @"message";


@interface VideoSum ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation VideoSum

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
            self.status = [self objectOrNilForKey:kVideoSumStatus fromDictionary:dict];
            self.data = [VideoData modelObjectWithDictionary:[dict objectForKey:kVideoSumData]];
            self.code = [[self objectOrNilForKey:kVideoSumCode fromDictionary:dict] doubleValue];
            self.message = [self objectOrNilForKey:kVideoSumMessage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kVideoSumStatus];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kVideoSumData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kVideoSumCode];
    [mutableDict setValue:self.message forKey:kVideoSumMessage];

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

    self.status = [aDecoder decodeObjectForKey:kVideoSumStatus];
    self.data = [aDecoder decodeObjectForKey:kVideoSumData];
    self.code = [aDecoder decodeDoubleForKey:kVideoSumCode];
    self.message = [aDecoder decodeObjectForKey:kVideoSumMessage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kVideoSumStatus];
    [aCoder encodeObject:_data forKey:kVideoSumData];
    [aCoder encodeDouble:_code forKey:kVideoSumCode];
    [aCoder encodeObject:_message forKey:kVideoSumMessage];
}

- (id)copyWithZone:(NSZone *)zone
{
    VideoSum *copy = [[VideoSum alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
        copy.message = [self.message copyWithZone:zone];
    }
    
    return copy;
}


@end
