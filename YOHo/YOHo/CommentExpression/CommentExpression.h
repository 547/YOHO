//
//  CommentExpression.h
//
//  Created by mac  on 16/4/9
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CommentData;

@interface CommentExpression : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) CommentData *data;
@property (nonatomic, assign) double code;
@property (nonatomic, strong) NSString *message;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
