//
//  CustomizationNavBar.m
//  YOHo
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "CustomizationNavBar.h"
#import "Data.h"
#import <UIView+SDAutoLayout.h>
@implementation CustomizationNavBar

-(id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, WIDTH, 64);
        self.backgroundColor = [UIColor whiteColor];
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 63.5, WIDTH, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
    }
    return self;
}

-(void)setLeftButton:(UIButton *)leftButton
{
    _leftButton = leftButton;
    _leftButton.frame = CGRectMake(20, 19, 35, 35);
    [self addSubview:_leftButton];
}

-(void)setTitleLabel:(UILabel *)titleLabel
{
    _titleLabel = titleLabel;
    _titleLabel.center = CGPointMake(self.center.x, self.center.y+10);
    _titleLabel.sd_layout.heightIs(30)
    .widthRatioToView(self,0.8);
    [self addSubview:_titleLabel];
    
}

-(void)setEnableContentViewTap:(BOOL)enableContentViewTap
{
    _enableContentViewTap = enableContentViewTap;
    if (_enableContentViewTap) {
        if (_titleLabel) {
            [_titleLabel removeFromSuperview];
        }
        if (_leftButton.frame.size.height>0) {
            _leftButton.frame = CGRectMake(0, 0, 0, 0);
        }
        _leftButton.sd_layout.heightIs(35)
        .leftSpaceToView(self,10)
        .centerYIs(self.centerY+10)
        .widthIs(WIDTH);
        
        
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
