//
//  MainTableViewCell.h
//  YOHo
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModels.h"
@interface MainTableViewCell : UITableViewCell
@property(nonatomic,strong)VideoContent *contentModel;
@property(nonatomic,strong)UIImageView *topImage;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *nextTitleLabel;
@property(nonatomic,strong)UILabel *summaryLabel;
@property(nonatomic,strong)UILabel *channelLabel;
@end
