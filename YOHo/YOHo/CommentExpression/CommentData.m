//
//  CommentData.m
//
//  Created by mac  on 16/4/9
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CommentData.h"


NSString *const kCommentDataWowCount = @"wowCount";
NSString *const kCommentDataUserWow = @"userWow";
NSString *const kCommentDataWtfCount = @"wtfCount";
NSString *const kCommentDataUserZzz = @"userZzz";
NSString *const kCommentDataZzzCount = @"zzzCount";
NSString *const kCommentDataUserWtf = @"userWtf";
NSString *const kCommentDataCommentCount = @"commentCount";


@interface CommentData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CommentData

@synthesize wowCount = _wowCount;
@synthesize userWow = _userWow;
@synthesize wtfCount = _wtfCount;
@synthesize userZzz = _userZzz;
@synthesize zzzCount = _zzzCount;
@synthesize userWtf = _userWtf;
@synthesize commentCount = _commentCount;


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
            self.wowCount = [[self objectOrNilForKey:kCommentDataWowCount fromDictionary:dict] doubleValue];
            self.userWow = [[self objectOrNilForKey:kCommentDataUserWow fromDictionary:dict] doubleValue];
            self.wtfCount = [[self objectOrNilForKey:kCommentDataWtfCount fromDictionary:dict] doubleValue];
            self.userZzz = [[self objectOrNilForKey:kCommentDataUserZzz fromDictionary:dict] doubleValue];
            self.zzzCount = [[self objectOrNilForKey:kCommentDataZzzCount fromDictionary:dict] doubleValue];
            self.userWtf = [[self objectOrNilForKey:kCommentDataUserWtf fromDictionary:dict] doubleValue];
            self.commentCount = [[self objectOrNilForKey:kCommentDataCommentCount fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.wowCount] forKey:kCommentDataWowCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userWow] forKey:kCommentDataUserWow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.wtfCount] forKey:kCommentDataWtfCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userZzz] forKey:kCommentDataUserZzz];
    [mutableDict setValue:[NSNumber numberWithDouble:self.zzzCount] forKey:kCommentDataZzzCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userWtf] forKey:kCommentDataUserWtf];
    [mutableDict setValue:[NSNumber numberWithDouble:self.commentCount] forKey:kCommentDataCommentCount];

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

    self.wowCount = [aDecoder decodeDoubleForKey:kCommentDataWowCount];
    self.userWow = [aDecoder decodeDoubleForKey:kCommentDataUserWow];
    self.wtfCount = [aDecoder decodeDoubleForKey:kCommentDataWtfCount];
    self.userZzz = [aDecoder decodeDoubleForKey:kCommentDataUserZzz];
    self.zzzCount = [aDecoder decodeDoubleForKey:kCommentDataZzzCount];
    self.userWtf = [aDecoder decodeDoubleForKey:kCommentDataUserWtf];
    self.commentCount = [aDecoder decodeDoubleForKey:kCommentDataCommentCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_wowCount forKey:kCommentDataWowCount];
    [aCoder encodeDouble:_userWow forKey:kCommentDataUserWow];
    [aCoder encodeDouble:_wtfCount forKey:kCommentDataWtfCount];
    [aCoder encodeDouble:_userZzz forKey:kCommentDataUserZzz];
    [aCoder encodeDouble:_zzzCount forKey:kCommentDataZzzCount];
    [aCoder encodeDouble:_userWtf forKey:kCommentDataUserWtf];
    [aCoder encodeDouble:_commentCount forKey:kCommentDataCommentCount];
}

- (id)copyWithZone:(NSZone *)zone
{
    CommentData *copy = [[CommentData alloc] init];
    
    if (copy) {

        copy.wowCount = self.wowCount;
        copy.userWow = self.userWow;
        copy.wtfCount = self.wtfCount;
        copy.userZzz = self.userZzz;
        copy.zzzCount = self.zzzCount;
        copy.userWtf = self.userWtf;
        copy.commentCount = self.commentCount;
    }
    
    return copy;
}


@end
