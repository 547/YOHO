//
//  ContentView.m
//  YOHo
//
//  Created by mac on 16/3/31.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ContentView.h"

@implementation ContentView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addCycleScrollView];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self addCycleScrollView];
    }
    return self;
}




/**添加轮播视图*/
-(void)addCycleScrollView
{
    NSMutableArray *imageUrls = [[NSMutableArray alloc]init];
    for (BannerClass *banner in _banners) {
        NSString *url = banner.image;
        [imageUrls addObject:url];
    }
    
    _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH, 150*HEIGHTMULTIPLE) delegate:self placeholderImage:nil];
    _cycleView.imageURLStringsGroup = imageUrls;
    _cycleView.showPageControl = YES;
    _cycleView.delegate = self;
    [self addSubview:_cycleView];
}

#pragma mark==
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"点击SDCycleScrollView");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
