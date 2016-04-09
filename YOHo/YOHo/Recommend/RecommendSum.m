//
//  RecommendSum.m
//
//  Created by mac  on 16/4/8
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "RecommendSum.h"
#import "RecommendData.h"


NSString *const kRecommendSumStatus = @"status";
NSString *const kRecommendSumData = @"data";
NSString *const kRecommendSumCode = @"code";
NSString *const kRecommendSumMessage = @"message";


@interface RecommendSum ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RecommendSum

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
            self.status = [self objectOrNilForKey:kRecommendSumStatus fromDictionary:dict];
    NSObject *receivedRecommendData = [dict objectForKey:kRecommendSumData];
    NSMutableArray *parsedRecommendData = [NSMutableArray array];
    if ([receivedRecommendData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedRecommendData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedRecommendData addObject:[RecommendData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedRecommendData isKindOfClass:[NSDictionary class]]) {
       [parsedRecommendData addObject:[RecommendData modelObjectWithDictionary:(NSDictionary *)receivedRecommendData]];
    }

    self.data = [NSArray arrayWithArray:parsedRecommendData];
            self.code = [[self objectOrNilForKey:kRecommendSumCode fromDictionary:dict] doubleValue];
            self.message = [self objectOrNilForKey:kRecommendSumMessage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kRecommendSumStatus];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kRecommendSumData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kRecommendSumCode];
    [mutableDict setValue:self.message forKey:kRecommendSumMessage];

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

    self.status = [aDecoder decodeObjectForKey:kRecommendSumStatus];
    self.data = [aDecoder decodeObjectForKey:kRecommendSumData];
    self.code = [aDecoder decodeDoubleForKey:kRecommendSumCode];
    self.message = [aDecoder decodeObjectForKey:kRecommendSumMessage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kRecommendSumStatus];
    [aCoder encodeObject:_data forKey:kRecommendSumData];
    [aCoder encodeDouble:_code forKey:kRecommendSumCode];
    [aCoder encodeObject:_message forKey:kRecommendSumMessage];
}

- (id)copyWithZone:(NSZone *)zone
{
    RecommendSum *copy = [[RecommendSum alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
        copy.message = [self.message copyWithZone:zone];
    }
    
    return copy;
}


@end
