//
//  CommentExpression.m
//
//  Created by mac  on 16/4/9
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CommentExpression.h"
#import "CommentData.h"


NSString *const kCommentExpressionStatus = @"status";
NSString *const kCommentExpressionData = @"data";
NSString *const kCommentExpressionCode = @"code";
NSString *const kCommentExpressionMessage = @"message";


@interface CommentExpression ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CommentExpression

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
            self.status = [self objectOrNilForKey:kCommentExpressionStatus fromDictionary:dict];
            self.data = [CommentData modelObjectWithDictionary:[dict objectForKey:kCommentExpressionData]];
            self.code = [[self objectOrNilForKey:kCommentExpressionCode fromDictionary:dict] doubleValue];
            self.message = [self objectOrNilForKey:kCommentExpressionMessage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kCommentExpressionStatus];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kCommentExpressionData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kCommentExpressionCode];
    [mutableDict setValue:self.message forKey:kCommentExpressionMessage];

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

    self.status = [aDecoder decodeObjectForKey:kCommentExpressionStatus];
    self.data = [aDecoder decodeObjectForKey:kCommentExpressionData];
    self.code = [aDecoder decodeDoubleForKey:kCommentExpressionCode];
    self.message = [aDecoder decodeObjectForKey:kCommentExpressionMessage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kCommentExpressionStatus];
    [aCoder encodeObject:_data forKey:kCommentExpressionData];
    [aCoder encodeDouble:_code forKey:kCommentExpressionCode];
    [aCoder encodeObject:_message forKey:kCommentExpressionMessage];
}

- (id)copyWithZone:(NSZone *)zone
{
    CommentExpression *copy = [[CommentExpression alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
        copy.message = [self.message copyWithZone:zone];
    }
    
    return copy;
}


@end
