//
//  ReadingMagazineViewController.m
//  YOHo
//
//  Created by mac on 16/4/11.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ReadingMagazineViewController.h"
#import "NSString+More.h"
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
@interface ReadingMagazineViewController ()

@end

@implementation ReadingMagazineViewController
{
    NSMutableArray *fileLists;
    NSMutableArray *coverLists;
    UIWebView *web;
    UIButton *showHidden;
    UIView *topBarView;
    UIScrollView *bottomScroll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    fileLists = [[NSMutableArray alloc]init];
    coverLists = [[NSMutableArray alloc]init];
    [self getAllFile];

    [self initUI];
}

#pragma mark==遍历所有w文件
/**
 NSString *path=@"System/Library/"; // 要列出来的目录
 
 NSFileManager *myFileManager=[NSFileManager defaultManager];
 
 NSDirectoryEnumerator *myDirectoryEnumerator;
 
 myDirectoryEnumerator=[myFileManager enumeratorAtPath:path];
 
 //列举目录内容，可以遍历子目录
 
 NSLog(@"用enumeratorAtPath:显示目录%@的内容：",path);
 
 while((path=[myDirectoryEnumerator nextObject])!=nil)
 
 {
 
 NSLog(@"%@",path);
 
 }
 ***/
-(NSArray *)getFilenamelistOfType:(NSString *)type fromDirPath:(NSString *)dirPath
{
    NSMutableArray *filenamelist = [[NSMutableArray alloc]init];
    NSArray *fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath error:nil];
    
    for (NSString *filename in fileList) {
        
        NSLog(@"fileName===%@",filename);
//        pathExtension===获取扩展名的方法
        
            if ([[filename pathExtension] isEqualToString:type]) {
                [filenamelist  addObject:filename];
            }
        
    }
    
    return filenamelist;
}

-(void)getAllFile
{
    
    NSString *unZipPath = [NSString getToDocumentsWithFileName:_magazine.journal];
    _savePath = [NSString stringWithFormat:@"%@.zip",unZipPath];
    
    NSFileManager *file = [NSFileManager defaultManager];
    if (![file fileExistsAtPath:unZipPath]) {
        [file createDirectoryAtPath:unZipPath withIntermediateDirectories:YES attributes:nil error:nil];
        //解压
        [SSZipArchive unzipFileAtPath:_savePath toDestination: unZipPath];
    }
    
    NSArray *fileList = [[NSArray alloc]init];
    
    NSError *error = nil;
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    fileList = [file contentsOfDirectoryAtPath:unZipPath error:&error];
    for (NSString *pathList in fileList) {
        if (![pathList containsString:@"."]) {
            NSString *pa = [NSString stringWithFormat:@"%@/%@",unZipPath,pathList];
            NSLog(@"pa=====%@",pa);
            [fileLists addObject:pa];

        }
}
}


#pragma mark===初始化UI
-(void)initUI
{
    self.navigationController.navigationBar.hidden = YES;
    web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipWeb:)];
    [web addGestureRecognizer:swipLeft];
    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipWeb:)];
    [web addGestureRecognizer:swipRight];
    [self.view addSubview:web];
    NSString *path = fileLists[0];
    [self loadDocumentPath:path];
    
    showHidden = [[UIButton alloc]init];
    [self.view addSubview:showHidden];
    [showHidden setBackgroundImage:[UIImage imageNamed:@"list.png"] forState:UIControlStateNormal];
    [showHidden addTarget:self action:@selector(showTheHiddenView) forControlEvents:UIControlEventTouchUpInside];
    CGFloat margin = 20;
    showHidden.sd_layout
    .rightSpaceToView(self.view,margin)
    .bottomSpaceToView(self.view,margin)
    .heightIs(2*margin)
    .widthEqualToHeight();
    showHidden.layer.cornerRadius = margin;
    showHidden.layer.masksToBounds = YES;
}

-(void)swipWeb:(UISwipeGestureRecognizer *)swip
{
    switch (swip.direction) {
        case UISwipeGestureRecognizerDirectionRight:
            //
        {
            NSLog(@"左滑");
        }
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            //
        {
            NSLog(@"右滑");
        }
            break;
            
        default:
            break;
    }
}

//加载app中html函数
- (void)loadDocumentPath:(NSString *)path{
    
    
    NSString *aPath = [path stringByAppendingPathComponent:@"app.html"];
        NSURL *url = [NSURL fileURLWithPath:aPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    web.scalesPageToFit = YES;
    [web loadRequest:request];
}

#pragma mark===展示隐藏的视图
-(void)showTheHiddenView
{
    showHidden.hidden = YES;
    [self addTopBar];
//    [self addBottomScrollView];
    
    
}


#pragma mark===添加底部scrollView目录
-(void)addBottomScrollView
{
    bottomScroll = [[UIScrollView alloc]init];
    [self.view addSubview:bottomScroll];
    bottomScroll.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.5];
    CGFloat y = HEIGHT - HEIGHT*1/5;
    bottomScroll.frame = CGRectMake(0, y, WIDTH, HEIGHT*1/5);
}

#pragma mark===添加假导航
/**添加假导航*/
-(void)addTopBar
{
    topBarView = [[UIView alloc]init];
    [self.view addSubview:topBarView];
    topBarView.frame = CGRectMake(0, 0, WIDTH, BARHEIGHT);
    topBarView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.5];
    UIButton *backButton = [[UIButton alloc]init];
    
    [topBarView addSubview:backButton];
    
    backButton.sd_layout
    .leftSpaceToView(topBarView,MAGIN)
    .centerYEqualToView(topBarView)
    .widthIs(3.5*MAGIN)
    .heightEqualToWidth();
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"shared_back_whiteEMG@2x.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shareButton = [[UIButton alloc]init];
    [topBarView addSubview:shareButton];
    
    shareButton.sd_layout
    .rightSpaceToView(topBarView,MAGIN)
    .centerYEqualToView(topBarView)
    .widthIs(backButton.frame.size.width)
    .heightEqualToWidth();
    
    [shareButton setBackgroundImage:[UIImage imageNamed:@"zine_shareIcon_normal.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark 返回
/**返回**/
-(void)back:(UIButton *)button
{
    NSLog(@"返回");
    MainViewController *main = [[MainViewController alloc]init];
    main.selectChannel = @"杂志";
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:main] animated:YES];
    
}


#pragma mark 分享
/**分享**/
-(void)share:(UIButton *)button
{
    NSLog(@"分享");
    [self showShareActionSheet:self.view];
}

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



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:web];
    if (CGRectContainsPoint(web.frame, point)) {
        //展示隐藏的视图
        [self showTheHiddenView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
