//
//  ContentDeContentsSpan.m
//
//  Created by mac  on 16/4/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ContentDeContentsSpan.h"


NSString *const kContentDeContentsSpanStyle = @"style";
NSString *const kContentDeContentsSpanText = @"text";


@interface ContentDeContentsSpan ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ContentDeContentsSpan

@synthesize style = _style;
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
            self.style = [self objectOrNilForKey:kContentDeContentsSpanStyle fromDictionary:dict];
            self.text = [self objectOrNilForKey:kContentDeContentsSpanText fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.style forKey:kContentDeContentsSpanStyle];
    [mutableDict setValue:self.text forKey:kContentDeContentsSpanText];

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

    self.style = [aDecoder decodeObjectForKey:kContentDeContentsSpanStyle];
    self.text = [aDecoder decodeObjectForKey:kContentDeContentsSpanText];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_style forKey:kContentDeContentsSpanStyle];
    [aCoder encodeObject:_text forKey:kContentDeContentsSpanText];
}

- (id)copyWithZone:(NSZone *)zone
{
    ContentDeContentsSpan *copy = [[ContentDeContentsSpan alloc] init];
    
    if (copy) {

        copy.style = [self.style copyWithZone:zone];
        copy.text = [self.text copyWithZone:zone];
    }
    
    return copy;
}


@end
