//
//  SplashViewController.m
//  YOHo
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "SplashViewController.h"
#import "Data.h"
#import "MainViewController.h"
#import "TypeViewController.h"
#import <UIImageView+WebCache.h>
#import <RESideMenu.h>
#import "RequestAppInfo.h"
#import "RequestSplashImage.h"
#import "RequestSettinginfo.h"
#import "RequestChannelInfo.h"
@interface SplashViewController ()

@end

@implementation SplashViewController
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [RequestAppInfo saveVersion];
//    [RequestSettinginfo saveSetting];
//    [RequestChannelInfo saveChannel];
}

-(void)getPicUrl
{
//    [RequestSplashImage getSplashImageSuccess:^(NSString *picUrl) {
//        NSLog(@"===%@",picUrl);
//        pic = picUrl;
//    }];
    

}

/**初始化UI*/
-(void)initUI
{
//广告
    UIImageView *splashImageView = [[UIImageView alloc]init];
    splashImageView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);

    [RequestSplashImage getSplashImageSuccess:^(NSString *picUrl) {
        NSLog(@"%@",picUrl);
    [splashImageView sd_setImageWithURL:[NSURL URLWithString:picUrl]];
    }];
    [self.view addSubview:splashImageView];
    NSString *buttonTitle = @"跳过 3S";
//跳过按钮
    UIButton *ignoreButton = [[UIButton alloc]init];
    ignoreButton.frame = CGRectMake(IGNOREBUTTONX*WIDTHMULTIPLE, IGNOREBUTTONY*HEIGHTMULTIPLE, IGNOREBUTTONW*WIDTHMULTIPLE, IGNOREBUTTONH);
    ignoreButton.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.7];
    ignoreButton.layer.cornerRadius
    = 6;
    ignoreButton.layer.masksToBounds = YES;
    [ignoreButton setTitle:buttonTitle forState:UIControlStateNormal];
    [ignoreButton addTarget:self action:@selector(goToMain) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ignoreButton];
}


/**前往主界面*/
-(void)goToMain
{
    MainViewController *main = [[MainViewController alloc]init];
    TypeViewController *type = [[TypeViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:main];
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc]initWithContentViewController:nav leftMenuViewController:type rightMenuViewController:nil];
    //设置不缩放背景图
    sideMenuViewController.scaleBackgroundImageView = NO;
    //设置不缩放正文界面
    sideMenuViewController.scaleContentView = NO;
    //设置不缩放菜单视图
    sideMenuViewController.scaleMenuView = NO;
    //设置抽屉的宽度
    sideMenuViewController.contentViewInPortraitOffsetCenterX = 120;
    //设置阴影
    sideMenuViewController.contentViewShadowEnabled = YES;
    sideMenuViewController.contentViewShadowColor = [UIColor lightGrayColor];
    /* The shadow offset. Defaults to (0, -3). Animatable. */
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(-3, 0);
    /* The opacity of the shadow. Defaults to 0. Specifying a value outside the
     * [0,1] range will give undefined results. Animatable. */
    sideMenuViewController.contentViewShadowOpacity = 0.5;
    /* The blur radius used to create the shadow. Defaults to 3. Animatable. */

    sideMenuViewController.contentViewShadowRadius = 10;
    [[UIApplication sharedApplication].delegate window].rootViewController = sideMenuViewController;
}















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
