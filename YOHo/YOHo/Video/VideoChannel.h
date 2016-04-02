//
//  VideoChannel.h
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface VideoChannel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *channelIdentifier;
@property (nonatomic, strong) NSString *channelNameEn;
@property (nonatomic, strong) NSString *channelNameCn;
@property (nonatomic, strong) NSString *channelName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
