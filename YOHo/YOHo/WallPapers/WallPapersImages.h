//
//  WallPapersImages.h
//
//  Created by mac  on 16/4/2
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WallPapersImages : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *app;
@property (nonatomic, strong) NSString *imagesIdentifier;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *sourceImage;
@property (nonatomic, strong) NSString *thumbImage;
@property (nonatomic, strong) NSString *shareUrl;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
