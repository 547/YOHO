//
//  ContentDEDiv.m
//
//  Created by mac  on 16/4/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ContentDEDiv.h"
#import "ContentDEImg.h"
#import "ContentDEBr.h"


NSString *const kContentDEDivDiv = @"div";
NSString *const kContentDEDivStyle = @"style";
NSString *const kContentDEDivImg = @"img";
NSString *const kContentDEDivBr = @"br";


@interface ContentDEDiv ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ContentDEDiv

@synthesize div = _div;
@synthesize style = _style;
@synthesize img = _img;
@synthesize br = _br;


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
            self.div = [self objectOrNilForKey:kContentDEDivDiv fromDictionary:dict];
            self.style = [self objectOrNilForKey:kContentDEDivStyle fromDictionary:dict];
    NSObject *receivedContentDEImg = [dict objectForKey:kContentDEDivImg];
    NSMutableArray *parsedContentDEImg = [NSMutableArray array];
    if ([receivedContentDEImg isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedContentDEImg) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedContentDEImg addObject:[ContentDEImg modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedContentDEImg isKindOfClass:[NSDictionary class]]) {
       [parsedContentDEImg addObject:[ContentDEImg modelObjectWithDictionary:(NSDictionary *)receivedContentDEImg]];
    }

    self.img = [NSArray arrayWithArray:parsedContentDEImg];
    NSObject *receivedContentDEBr = [dict objectForKey:kContentDEDivBr];
    NSMutableArray *parsedContentDEBr = [NSMutableArray array];
    if ([receivedContentDEBr isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedContentDEBr) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedContentDEBr addObject:[ContentDEBr modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedContentDEBr isKindOfClass:[NSDictionary class]]) {
       [parsedContentDEBr addObject:[ContentDEBr modelObjectWithDictionary:(NSDictionary *)receivedContentDEBr]];
    }

    self.br = [NSArray arrayWithArray:parsedContentDEBr];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForDiv = [NSMutableArray array];
    for (NSObject *subArrayObject in self.div) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForDiv addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForDiv addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForDiv] forKey:kContentDEDivDiv];
    [mutableDict setValue:self.style forKey:kContentDEDivStyle];
    NSMutableArray *tempArrayForImg = [NSMutableArray array];
    for (NSObject *subArrayObject in self.img) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForImg addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForImg addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImg] forKey:kContentDEDivImg];
    NSMutableArray *tempArrayForBr = [NSMutableArray array];
    for (NSObject *subArrayObject in self.br) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForBr addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForBr addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBr] forKey:kContentDEDivBr];

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

    self.div = [aDecoder decodeObjectForKey:kContentDEDivDiv];
    self.style = [aDecoder decodeObjectForKey:kContentDEDivStyle];
    self.img = [aDecoder decodeObjectForKey:kContentDEDivImg];
    self.br = [aDecoder decodeObjectForKey:kContentDEDivBr];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_div forKey:kContentDEDivDiv];
    [aCoder encodeObject:_style forKey:kContentDEDivStyle];
    [aCoder encodeObject:_img forKey:kContentDEDivImg];
    [aCoder encodeObject:_br forKey:kContentDEDivBr];
}

- (id)copyWithZone:(NSZone *)zone
{
    ContentDEDiv *copy = [[ContentDEDiv alloc] init];
    
    if (copy) {

        copy.div = [self.div copyWithZone:zone];
        copy.style = [self.style copyWithZone:zone];
        copy.img = [self.img copyWithZone:zone];
        copy.br = [self.br copyWithZone:zone];
    }
    
    return copy;
}


@end
