//
//  BannerView.m
//  YOHo
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "BannerView.h"
#import <UIView+SDAutoLayout.h>
#import "NSString+More.h"
@implementation BannerView
{
    UIScrollView *bannerScroll;
    
    UILabel *lineLabel;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        bannerScroll = [[UIScrollView alloc]initWithFrame:frame];
        bannerScroll.pagingEnabled = YES;
        bannerScroll.bounces = NO;
        [self addSubview:bannerScroll];
        
    }
    return self;
}

-(void)setBannerArray:(NSArray *)bannerArray
{
    _bannerArray = bannerArray;
    bannerScroll.contentSize = CGSizeMake(80*_bannerArray.count, 20);
    
    for (int i=0; i<_bannerArray.count; i++) {
        UILabel *label = [[UILabel alloc]init];
       CGSize size = [NSString getFontSize:_bannerArray[i]];
        CGFloat number = i%_bannerArray.count;
        CGFloat x = 30+(30+size.width)*number;
        label.frame = CGRectMake(x, 5, size.width, 20);
        label.text = _bannerArray[i];
        [bannerScroll addSubview:label];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
