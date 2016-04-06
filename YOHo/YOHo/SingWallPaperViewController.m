//
//  SingWallPaperViewController.m
//  YOHo
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "SingWallPaperViewController.h"
#import "MainViewController.h"
#import <RESideMenu.h>
#define MAGIN 10
@interface SingWallPaperViewController ()

@end

@implementation SingWallPaperViewController
{
    UIImageView *contentImageView;
    UIView *topBarView;
    UIView *bottomToolView;
    UILabel *title;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}


#pragma mark==初始化UI
/**初始化UI**/
-(void)initUI
{
    self.navigationController.navigationBar.hidden = YES;
    [self addFullImageView];
    [self addTopBar];
    [self addBottonToolBar];
}

/**添加全屏ImageView**/
-(void)addFullImageView
{
    contentImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [contentImageView sd_setImageWithURL:[NSURL URLWithString:_image.sourceImage]];
    [self.view addSubview:contentImageView];
}

/**添加假导航*/
-(void)addTopBar
{
    topBarView = [[UIView alloc]init];
    [self.view addSubview:topBarView];
    topBarView.frame = CGRectMake(0, 0, WIDTH, BARHEIGHT);
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(MAGIN, topBarView.frame.size.height-1.0, topBarView.frame.size.width-2*MAGIN, 1.0)];
    line.backgroundColor = [UIColor whiteColor];
    [topBarView addSubview:line];
    
    UIButton *backButton = [[UIButton alloc]init];
    
    [topBarView addSubview:backButton];

    backButton.sd_layout
    .leftEqualToView(line)
    .centerYEqualToView(topBarView)
    .widthIs(3.5*MAGIN)
    .heightEqualToWidth();
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"shared_back_whiteEMG@2x.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shareButton = [[UIButton alloc]init];
    [topBarView addSubview:shareButton];

    shareButton.sd_layout
    .rightEqualToView(line)
    .centerYEqualToView(topBarView)
    .widthIs(backButton.frame.size.width)
    .heightEqualToWidth();
    
    [shareButton setBackgroundImage:[UIImage imageNamed:@"zine_shareIcon_normal.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *downloadButton = [[UIButton alloc]init];
    [topBarView addSubview:downloadButton];

    downloadButton.sd_layout
    .topEqualToView(shareButton)
    .rightSpaceToView(shareButton,MAGIN)
    .widthIs(shareButton.frame.size.width)
    .heightEqualToWidth();
    
    [downloadButton setBackgroundImage:[UIImage imageNamed:@"shared_download_normalEMG.png"] forState:UIControlStateNormal];
    [downloadButton addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchUpInside];
    
}

/**添加假工具栏*/
-(void)addBottonToolBar
{
    bottomToolView = [[UIView alloc]init];
    [self.view addSubview:bottomToolView];
    CGFloat h = HEIGHT*0.18;
    bottomToolView.frame = CGRectMake(0, HEIGHT-h, WIDTH, h);
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(MAGIN, 0, bottomToolView.frame.size.width-2*MAGIN, 1.0)];
    line.backgroundColor = [UIColor whiteColor];
    [bottomToolView addSubview:line];
    
    title = [[UILabel alloc]init];
    [bottomToolView addSubview:title];
    title.sd_layout
    .leftEqualToView(line)
    .topSpaceToView(line,2*MAGIN)
    .rightEqualToView(line)
    .widthIs(line.frame.size.width)
    .autoHeightRatio(0);
    title.numberOfLines = 0;
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:19];
    title.text = _image.title;
}

/**重写set方法*/
-(void)setImage:(WallPapersImages *)image
{
    _image = image;
    NSString *imageStr = image.sourceImage;
    NSURL *imageUrl = [NSURL URLWithString:imageStr];
    [contentImageView sd_setImageWithURL:imageUrl];
    title.text = image.title;
}


/**返回**/
-(void)back:(UIButton *)button
{
    NSLog(@"返回");
    MainViewController *main = [[MainViewController alloc]init];
    main.selectChannel = @"壁纸";
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:main] animated:YES];
    
}

/**分享**/
-(void)share:(UIButton *)button
{
    NSLog(@"分享");
}

/**下载**/
-(void)download:(UIButton *)button
{
    NSLog(@"下载");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
