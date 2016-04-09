//
//  SearchTWData.m
//
//  Created by mac  on 16/4/8
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "SearchTWData.h"
#import "SearchTWList.h"


NSString *const kSearchTWDataTotal = @"total";
NSString *const kSearchTWDataList = @"list";


@interface SearchTWData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SearchTWData

@synthesize total = _total;
@synthesize list = _list;


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
            self.total = [[self objectOrNilForKey:kSearchTWDataTotal fromDictionary:dict] doubleValue];
    NSObject *receivedSearchTWList = [dict objectForKey:kSearchTWDataList];
    NSMutableArray *parsedSearchTWList = [NSMutableArray array];
    if ([receivedSearchTWList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSearchTWList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSearchTWList addObject:[SearchTWList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSearchTWList isKindOfClass:[NSDictionary class]]) {
       [parsedSearchTWList addObject:[SearchTWList modelObjectWithDictionary:(NSDictionary *)receivedSearchTWList]];
    }

    self.list = [NSArray arrayWithArray:parsedSearchTWList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kSearchTWDataTotal];
    NSMutableArray *tempArrayForList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.list) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForList] forKey:kSearchTWDataList];

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

    self.total = [aDecoder decodeDoubleForKey:kSearchTWDataTotal];
    self.list = [aDecoder decodeObjectForKey:kSearchTWDataList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_total forKey:kSearchTWDataTotal];
    [aCoder encodeObject:_list forKey:kSearchTWDataList];
}

- (id)copyWithZone:(NSZone *)zone
{
    SearchTWData *copy = [[SearchTWData alloc] init];
    
    if (copy) {

        copy.total = self.total;
        copy.list = [self.list copyWithZone:zone];
    }
    
    return copy;
}


@end
