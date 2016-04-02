//
//  WallPapersSum.m
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "WallPapersSum.h"
#import "WallPapersData.h"


NSString *const kWallPapersSumStatus = @"status";
NSString *const kWallPapersSumData = @"data";
NSString *const kWallPapersSumCode = @"code";
NSString *const kWallPapersSumMessage = @"message";


@interface WallPapersSum ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WallPapersSum

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
            self.status = [self objectOrNilForKey:kWallPapersSumStatus fromDictionary:dict];
            self.data = [WallPapersData modelObjectWithDictionary:[dict objectForKey:kWallPapersSumData]];
            self.code = [[self objectOrNilForKey:kWallPapersSumCode fromDictionary:dict] doubleValue];
            self.message = [self objectOrNilForKey:kWallPapersSumMessage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kWallPapersSumStatus];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kWallPapersSumData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kWallPapersSumCode];
    [mutableDict setValue:self.message forKey:kWallPapersSumMessage];

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

    self.status = [aDecoder decodeObjectForKey:kWallPapersSumStatus];
    self.data = [aDecoder decodeObjectForKey:kWallPapersSumData];
    self.code = [aDecoder decodeDoubleForKey:kWallPapersSumCode];
    self.message = [aDecoder decodeObjectForKey:kWallPapersSumMessage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kWallPapersSumStatus];
    [aCoder encodeObject:_data forKey:kWallPapersSumData];
    [aCoder encodeDouble:_code forKey:kWallPapersSumCode];
    [aCoder encodeObject:_message forKey:kWallPapersSumMessage];
}

- (id)copyWithZone:(NSZone *)zone
{
    WallPapersSum *copy = [[WallPapersSum alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
        copy.message = [self.message copyWithZone:zone];
    }
    
    return copy;
}


@end
