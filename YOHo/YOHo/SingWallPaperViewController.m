//
//  SingWallPaperViewController.m
//  YOHo
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "SingWallPaperViewController.h"
#define MAGIN 10
@interface SingWallPaperViewController ()

@end

@implementation SingWallPaperViewController
{
    UIImageView *contentImageView;
    UIView *topBarView;
    UIView *bottomToolView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}


#pragma mark==初始化UI
/**初始化UI**/
-(void)initUI
{
    [self addFullImageView];
    [self addTopBar];
    [self addBottonToolBar];
}

/**添加全屏ImageView**/
-(void)addFullImageView
{
    contentImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:contentImageView];
}

/**添加假导航*/
-(void)addTopBar
{
    topBarView = [[UIView alloc]init];
    [self.view addSubview:topBarView];
}

/**添加假工具栏*/
-(void)addBottonToolBar
{
    bottomToolView = [[UIView alloc]init];
    [self.view addSubview:bottomToolView];
    bottomToolView.alpha = 0;
    bottomToolView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .heightRatioToView(self.view,0.2);
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(MAGIN, 0, bottomToolView.frame.size.width-2*MAGIN, 1.0)];
    line.backgroundColor = [UIColor whiteColor];
    [bottomToolView addSubview:line];
    
    UILabel *title = [[UILabel alloc]init];
    [bottomToolView addSubview:title];
    title.sd_layout
    .leftEqualToView(line)
    .topSpaceToView(line,MAGIN*2)
    .rightEqualToView(line)
    .autoHeightRatio(0);
    title.numberOfLines = 0;
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:20];
}

/**重写set方法*/
-(void)setImage:(WallPapersImages *)image
{
    _image = image;
    NSString *imageStr = image.sourceImage;
    NSURL *imageUrl = [NSURL URLWithString:imageStr];
    [contentImageView sd_setImageWithURL:imageUrl];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
