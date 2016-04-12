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
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>

#import <ShareSDKExtension/ShareSDK+Extension.h>
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
    [self showShareActionSheet:self.view];
}

/**下载**/
-(void)download:(UIButton *)button
{
    NSLog(@"下载");
}

//#pragma mark -
//
///**
// *  显示加载动画
// *
// *  @param flag YES 显示，NO 不显示
// */
//- (void)showLoadingView:(BOOL)flag
//{
//    if (flag)
//    {
//        [self.view addSubview:self.panelView];
//        [self.loadingView startAnimating];
//    }
//    else
//    {
//        [self.panelView removeFromSuperview];
//    }
//}


#pragma mark 显示分享菜单

/**
 *  显示分享菜单
 *
 *  @param view 容器视图
 */
- (void)showShareActionSheet:(UIView *)view
{
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
    
    
    //1、创建分享参数（必要）
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKEnableUseClientShare];
    NSArray* imageArray = @[[UIImage imageNamed:@"sinaWeiboSelected.png"]];
    [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                     images:imageArray
                                        url:[NSURL URLWithString:@"http://www.mob.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeAuto];
    
    //1.2、自定义分享平台（非必要）
    NSMutableArray *activePlatforms = [NSMutableArray arrayWithArray:[ShareSDK activePlatforms]];
    //添加一个自定义的平台（非必要）
    SSUIShareActionSheetCustomItem *item = [SSUIShareActionSheetCustomItem itemWithIcon:[UIImage imageNamed:@"Icon.png"]
                                                                                  label:@"自定义"
                                                                                onClick:^{
                                                                                    
                                                                                    //自定义item被点击的处理逻辑
                                                                                    NSLog(@"=== 自定义item被点击 ===");
                                                                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"自定义item被点击"
                                                                                                                                        message:nil
                                                                                                                                       delegate:nil
                                                                                                                              cancelButtonTitle:@"确定"
                                                                                                                              otherButtonTitles:nil];
                                                                                    [alertView show];
                                                                                }];
    [activePlatforms addObject:item];
    
    //设置分享菜单栏样式（非必要）
    //        [SSUIShareActionSheetStyle setActionSheetBackgroundColor:[UIColor colorWithRed:249/255.0 green:0/255.0 blue:12/255.0 alpha:0.5]];
    //        [SSUIShareActionSheetStyle setActionSheetColor:[UIColor colorWithRed:21.0/255.0 green:21.0/255.0 blue:21.0/255.0 alpha:1.0]];
    //        [SSUIShareActionSheetStyle setCancelButtonBackgroundColor:[UIColor colorWithRed:21.0/255.0 green:21.0/255.0 blue:21.0/255.0 alpha:1.0]];
    //        [SSUIShareActionSheetStyle setCancelButtonLabelColor:[UIColor whiteColor]];
    //        [SSUIShareActionSheetStyle setItemNameColor:[UIColor whiteColor]];
    //        [SSUIShareActionSheetStyle setItemNameFont:[UIFont systemFontOfSize:10]];
    //        [SSUIShareActionSheetStyle setCurrentPageIndicatorTintColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1.0]];
    //        [SSUIShareActionSheetStyle setPageIndicatorTintColor:[UIColor colorWithRed:62/255.0 green:62/255.0 blue:62/255.0 alpha:1.0]];
    
    //2、分享
    [ShareSDK showShareActionSheet:view
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                           
                       case SSDKResponseStateBegin:
                       {
//                           [theController showLoadingView:YES];
                           
                           break;
                       }
                       case SSDKResponseStateSuccess:
                       {
                           //Facebook Messenger、WhatsApp等平台捕获不到分享成功或失败的状态，最合适的方式就是对这些平台区别对待
//                           if (platformType == SSDKPlatformTypeFacebookMessenger)
//                           {
//                               break;
//                           }
//                           
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           break;
                       }
                       case SSDKResponseStateCancel:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       default:
                           break;
                   }
                   
//                   if (state != SSDKResponseStateBegin)
//                   {
//                       [theController showLoadingView:NO];
//                       [theController.tableView reloadData];
//                   }
                   
               }];
    
    //另附：设置跳过分享编辑页面，直接分享的平台。
    //        SSUIShareActionSheetController *sheet = [ShareSDK showShareActionSheet:view
    //                                                                         items:nil
    //                                                                   shareParams:shareParams
    //                                                           onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
    //                                                           }];
    //
    //        //删除和添加平台示例
    //        [sheet.directSharePlatforms removeObject:@(SSDKPlatformTypeWechat)];
    //        [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
