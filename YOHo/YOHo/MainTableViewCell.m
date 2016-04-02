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
#import <UIImageView+WebCache.h>
#define width self.frame.size.width
#define height self.frame.size.height
@implementation MainTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

/**初始化UI**/
-(void)initUI
{
    UIView *content = self.contentView;

    _topImage = [[UIImageView alloc]init];
    _topImage.userInteractionEnabled = NO;
    [content addSubview:_topImage];
    
    _channelLabel = [[UILabel alloc]init];
    _channelLabel.backgroundColor = [UIColor blackColor];
    _channelLabel.textColor = [UIColor whiteColor];
    _channelLabel.textAlignment = UITextAlignmentCenter;
    [_topImage addSubview:_channelLabel];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.numberOfLines = 2;
    _titleLabel.textColor = [UIColor lightGrayColor];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    [content addSubview:_titleLabel];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.numberOfLines = 1;
    _timeLabel.textColor = [UIColor lightGrayColor];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    [content addSubview:_timeLabel];
    
    _nextTitleLabel = [[UILabel alloc]init];
    _nextTitleLabel.numberOfLines = 2;
    _nextTitleLabel.textColor = [UIColor lightGrayColor];
    _nextTitleLabel.font = [UIFont systemFontOfSize:20];
    [content addSubview:_nextTitleLabel];
    
    
    _summaryLabel = [[UILabel alloc]init];
    _summaryLabel.numberOfLines = 2;
    _summaryLabel.textColor = [UIColor lightGrayColor];
    _summaryLabel.font = [UIFont systemFontOfSize:15];
    [content addSubview:_summaryLabel];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = [UIColor lightGrayColor];
    [content addSubview:line];
    
    CGFloat bigMargin = 20;
    CGFloat margin = 10;
    _topImage.sd_layout
    .leftSpaceToView(content,margin)
    .topSpaceToView(content,bigMargin)
    .rightSpaceToView(content,margin)
    .heightRatioToView(content,0.45);
    
    _channelLabel.sd_layout
    .leftSpaceToView(_topImage,0)
    .topSpaceToView(_topImage,0)
    .widthRatioToView(_topImage,0.2)
    .heightIs(30);
    
    
    _titleLabel.sd_layout
    .leftSpaceToView(content,margin)
    .topSpaceToView(_topImage,bigMargin-margin)
    .widthRatioToView(content,0.65)
    .autoHeightRatio(0);
    
    _timeLabel.sd_layout
    .topSpaceToView(_topImage,bigMargin-5)
    .leftSpaceToView(_titleLabel,margin)
    .heightIs(18);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    _nextTitleLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_titleLabel,bigMargin-margin)
    .rightSpaceToView(content,margin)
    .autoHeightRatio(0);
    
    _summaryLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_nextTitleLabel,bigMargin-margin)
    .rightSpaceToView(content,margin)
    .heightIs(40);
    
    line.sd_layout
    .leftSpaceToView(content,0)
    .topSpaceToView(_summaryLabel,bigMargin)
    .widthRatioToView(content,1)
    .heightIs(0.5);
    

    
    
}

-(void)setContentModel:(ContentClass *)contentModel
{

    _contentModel = contentModel;
//    [_topImage loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:contentModel.image]]];
    [_topImage sd_setImageWithURL:[NSURL URLWithString:contentModel.image]];
    if ([contentModel.channel.channel_name_cn isEqualToString:@"时尚"]) {
        _channelLabel.backgroundColor = [UIColor magentaColor];
        _titleLabel.textColor = [UIColor blackColor];
        _nextTitleLabel.textColor = [UIColor blackColor];
        _summaryLabel.textColor = [UIColor blackColor];
    }
    _channelLabel.text = contentModel.channel.channel_name_cn;
    _titleLabel.text = contentModel.title;
    _timeLabel.text =contentModel.publishTime;
    [_timeLabel sizeToFit];// 防止单行文本label在重用时宽度计算不准的问题
    _nextTitleLabel.text = contentModel.subtitle;
    _summaryLabel.text = contentModel.summary;
    
}



- (void)awakeFromNib {
    // Initialization code
    
//    _topImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, WIDTH-20, 120)];
//    [self.contentView addSubview:_topImage];
//    _timeLabel = [UILabel alloc]init;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
