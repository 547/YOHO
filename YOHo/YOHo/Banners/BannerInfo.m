//
//  BannerInfo.m
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "BannerInfo.h"
#import "BannerData.h"


NSString *const kBannerInfoStatus = @"status";
NSString *const kBannerInfoData = @"data";
NSString *const kBannerInfoCode = @"code";
NSString *const kBannerInfoMessage = @"message";


@interface BannerInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BannerInfo

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
            self.status = [self objectOrNilForKey:kBannerInfoStatus fromDictionary:dict];
    NSObject *receivedBannerData = [dict objectForKey:kBannerInfoData];
    NSMutableArray *parsedBannerData = [NSMutableArray array];
    if ([receivedBannerData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBannerData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBannerData addObject:[BannerData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBannerData isKindOfClass:[NSDictionary class]]) {
       [parsedBannerData addObject:[BannerData modelObjectWithDictionary:(NSDictionary *)receivedBannerData]];
    }

    self.data = [NSArray arrayWithArray:parsedBannerData];
            self.code = [[self objectOrNilForKey:kBannerInfoCode fromDictionary:dict] doubleValue];
            self.message = [self objectOrNilForKey:kBannerInfoMessage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kBannerInfoStatus];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kBannerInfoData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kBannerInfoCode];
    [mutableDict setValue:self.message forKey:kBannerInfoMessage];

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

    self.status = [aDecoder decodeObjectForKey:kBannerInfoStatus];
    self.data = [aDecoder decodeObjectForKey:kBannerInfoData];
    self.code = [aDecoder decodeDoubleForKey:kBannerInfoCode];
    self.message = [aDecoder decodeObjectForKey:kBannerInfoMessage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kBannerInfoStatus];
    [aCoder encodeObject:_data forKey:kBannerInfoData];
    [aCoder encodeDouble:_code forKey:kBannerInfoCode];
    [aCoder encodeObject:_message forKey:kBannerInfoMessage];
}

- (id)copyWithZone:(NSZone *)zone
{
    BannerInfo *copy = [[BannerInfo alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
        copy.message = [self.message copyWithZone:zone];
    }
    
    return copy;
}


@end
