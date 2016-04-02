//
//  MagazineSum.m
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "MagazineSum.h"
#import "MagazineData.h"


NSString *const kMagazineSumStatus = @"status";
NSString *const kMagazineSumData = @"data";
NSString *const kMagazineSumCode = @"code";
NSString *const kMagazineSumMessage = @"message";


@interface MagazineSum ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MagazineSum

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
            self.status = [self objectOrNilForKey:kMagazineSumStatus fromDictionary:dict];
    NSObject *receivedMagazineData = [dict objectForKey:kMagazineSumData];
    NSMutableArray *parsedMagazineData = [NSMutableArray array];
    if ([receivedMagazineData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedMagazineData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedMagazineData addObject:[MagazineData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedMagazineData isKindOfClass:[NSDictionary class]]) {
       [parsedMagazineData addObject:[MagazineData modelObjectWithDictionary:(NSDictionary *)receivedMagazineData]];
    }

    self.data = [NSArray arrayWithArray:parsedMagazineData];
            self.code = [[self objectOrNilForKey:kMagazineSumCode fromDictionary:dict] doubleValue];
            self.message = [self objectOrNilForKey:kMagazineSumMessage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kMagazineSumStatus];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kMagazineSumData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kMagazineSumCode];
    [mutableDict setValue:self.message forKey:kMagazineSumMessage];

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

    self.status = [aDecoder decodeObjectForKey:kMagazineSumStatus];
    self.data = [aDecoder decodeObjectForKey:kMagazineSumData];
    self.code = [aDecoder decodeDoubleForKey:kMagazineSumCode];
    self.message = [aDecoder decodeObjectForKey:kMagazineSumMessage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kMagazineSumStatus];
    [aCoder encodeObject:_data forKey:kMagazineSumData];
    [aCoder encodeDouble:_code forKey:kMagazineSumCode];
    [aCoder encodeObject:_message forKey:kMagazineSumMessage];
}

- (id)copyWithZone:(NSZone *)zone
{
    MagazineSum *copy = [[MagazineSum alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
        copy.message = [self.message copyWithZone:zone];
    }
    
    return copy;
}


@end
