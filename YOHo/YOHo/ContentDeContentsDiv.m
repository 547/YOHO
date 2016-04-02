//
//  ContentDeContentsDiv.m
//
//  Created by mac  on 16/4/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ContentDeContentsDiv.h"
#import "ContentDeContentsImg.h"
#import "ContentDeContentsBr.h"


NSString *const kContentDeContentsDivDiv = @"div";
NSString *const kContentDeContentsDivStyle = @"style";
NSString *const kContentDeContentsDivImg = @"img";
NSString *const kContentDeContentsDivBr = @"br";
NSString *const kContentDeContentsDivText = @"text";


@interface ContentDeContentsDiv ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ContentDeContentsDiv

@synthesize div = _div;
@synthesize style = _style;
@synthesize img = _img;
@synthesize br = _br;
@synthesize text = _text;


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
            self.div = [self objectOrNilForKey:kContentDeContentsDivDiv fromDictionary:dict];
            self.style = [self objectOrNilForKey:kContentDeContentsDivStyle fromDictionary:dict];
    NSObject *receivedContentDeContentsImg = [dict objectForKey:kContentDeContentsDivImg];
    NSMutableArray *parsedContentDeContentsImg = [NSMutableArray array];
    if ([receivedContentDeContentsImg isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedContentDeContentsImg) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedContentDeContentsImg addObject:[ContentDeContentsImg modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedContentDeContentsImg isKindOfClass:[NSDictionary class]]) {
       [parsedContentDeContentsImg addObject:[ContentDeContentsImg modelObjectWithDictionary:(NSDictionary *)receivedContentDeContentsImg]];
    }

    self.img = [NSArray arrayWithArray:parsedContentDeContentsImg];
    NSObject *receivedContentDeContentsBr = [dict objectForKey:kContentDeContentsDivBr];
    NSMutableArray *parsedContentDeContentsBr = [NSMutableArray array];
    if ([receivedContentDeContentsBr isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedContentDeContentsBr) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedContentDeContentsBr addObject:[ContentDeContentsBr modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedContentDeContentsBr isKindOfClass:[NSDictionary class]]) {
       [parsedContentDeContentsBr addObject:[ContentDeContentsBr modelObjectWithDictionary:(NSDictionary *)receivedContentDeContentsBr]];
    }

    self.br = [NSArray arrayWithArray:parsedContentDeContentsBr];
            self.text = [self objectOrNilForKey:kContentDeContentsDivText fromDictionary:dict];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForDiv] forKey:kContentDeContentsDivDiv];
    [mutableDict setValue:self.style forKey:kContentDeContentsDivStyle];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImg] forKey:kContentDeContentsDivImg];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBr] forKey:kContentDeContentsDivBr];
    [mutableDict setValue:self.text forKey:kContentDeContentsDivText];

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

    self.div = [aDecoder decodeObjectForKey:kContentDeContentsDivDiv];
    self.style = [aDecoder decodeObjectForKey:kContentDeContentsDivStyle];
    self.img = [aDecoder decodeObjectForKey:kContentDeContentsDivImg];
    self.br = [aDecoder decodeObjectForKey:kContentDeContentsDivBr];
    self.text = [aDecoder decodeObjectForKey:kContentDeContentsDivText];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_div forKey:kContentDeContentsDivDiv];
    [aCoder encodeObject:_style forKey:kContentDeContentsDivStyle];
    [aCoder encodeObject:_img forKey:kContentDeContentsDivImg];
    [aCoder encodeObject:_br forKey:kContentDeContentsDivBr];
    [aCoder encodeObject:_text forKey:kContentDeContentsDivText];
}

- (id)copyWithZone:(NSZone *)zone
{
    ContentDeContentsDiv *copy = [[ContentDeContentsDiv alloc] init];
    
    if (copy) {

        copy.div = [self.div copyWithZone:zone];
        copy.style = [self.style copyWithZone:zone];
        copy.img = [self.img copyWithZone:zone];
        copy.br = [self.br copyWithZone:zone];
        copy.text = [self.text copyWithZone:zone];
    }
    
    return copy;
}


@end
