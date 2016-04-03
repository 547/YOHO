//
//  CustomerCollectionViewCell.m
//  YOHo
//
//  Created by mac on 16/4/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "CustomerCollectionViewCell.h"

@implementation CustomerCollectionViewCell
{
    UIImageView *contentImage;
    UILabel *nameLabel;
    UIButton *contentButton;
    
}
-(id)init
{
    self = [super init];
    if (self) {
        //
        [self initUI];
        self.downloadState = 0;
    }
    return self;
}

/**初始化UI***/
-(void)initUI
{
    UIView *content = self.contentView;
    
    contentImage = [[UIImageView alloc]init];
    contentImage.sd_layout
    .leftSpaceToView(content,0)
    .topSpaceToView(content,0)
    .rightSpaceToView(content,0)
    .bottomSpaceToView(content,20*HEIGHTMULTIPLE);
    [content addSubview:contentImage];
    
    
    contentButton = [[UIButton alloc]init];
    contentButton.frame = contentImage.frame;
    contentButton.backgroundColor = [UIColor clearColor];
    [contentButton addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
    [content addSubview:contentButton];
    
    nameLabel = [[UILabel alloc]init];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.numberOfLines = 1;
    nameLabel.font = [UIFont systemFontOfSize:10];
    nameLabel.textAlignment = UITextAlignmentCenter;
    nameLabel.sd_layout
    .leftEqualToView(contentImage)
    .topSpaceToView(contentImage,5)
    .rightSpaceToView(content,0)
    .bottomSpaceToView(content,0);
    [content addSubview:nameLabel];
}

-(void)setMagazine:(MagazineData *)magazine
{
    _magazine = magazine;
    
    [contentImage sd_setImageWithURL:[NSURL URLWithString:magazine.cover] placeholderImage:[UIImage imageNamed:@"magazineUndownloaded.png"]];
    nameLabel.text = magazine.journal;

}

-(void)setDownloadState:(DownLoadState)downloadState
{
    _downloadState = downloadState;
    switch (downloadState) {
        case 0:
            //没下载
            break;
        case 1:
            //正在下载
            break;
        case 2:
            //暂停下载
            break;
        case 3:
            //下载完成
            break;
            
        default:
            break;
    }
}

-(void)selectItem:(UIButton *)button
{
    
    [self.delegate customerCollectionViewCellClicked:_magazine];
}

@end
