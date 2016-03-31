//
//  MainTableViewCell.m
//  YOHo
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "MainTableViewCell.h"
#import "Data.h"
#import <UIView+SDAutoLayout.h>
@implementation MainTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _topImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, WIDTH-20, 120)];
    [self.contentView addSubview:_topImage];
//    _timeLabel = [UILabel alloc]init;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
