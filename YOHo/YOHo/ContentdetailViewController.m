//
//  ContentdetailViewController.m
//  YOHo
//
//  Created by mac on 16/4/7.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ContentdetailViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>

#import <ShareSDKExtension/ShareSDK+Extension.h>
@interface ContentdetailViewController ()<UIWebViewDelegate,UIScrollViewDelegate>

@end

@implementation ContentdetailViewController
{
    RecommendSum *recommendSum;
    BOOL isCancel;
    NSMutableArray *canceles;
    DTAttributedTextView *dtTextView;
    NSMutableArray *expressiones;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    isCancel = NO;//默认不取消
   
    canceles = [[NSMutableArray alloc]initWithObjects:[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO], nil];
    expressiones = [[NSMutableArray alloc]initWithCapacity:3];
    [self initUI];
    [self getExpression];
}


#pragma mark===初始化UI
/**初始化UI*/
-(void)initUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"YOHO!";
 
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backMian)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(comments)];
//    [self getComment];
    [self addWebView];
    [self addToolbar];
    
    
}


/**请求相关推荐**/
-(void)getComment
{
    NSString *app = @"2";
    NSString *cId = _contentDetail.data.contents.cid;
    __weak ContentdetailViewController *weakSelf = self;
    if (_contentDetail.isOne) {
        app = @"1";
    }
    [RequestContentDetail getRecommendSumWithCIdOrLink:cId app:app Success:^(RecommendSum *recommend) {
        //
        recommendSum = recommend;
    }];
}

/**前往评论页面**/
-(void)comments
{

}

/**请求表情*/
-(void)getExpression
{
    NSString *app = @"2";
    NSString *cId = _contentDetail.data.contents.cid;
    __weak ContentdetailViewController *weakSelf = self;
    if (_contentDetail.isOne) {
        app = @"1";
        [RequestContentDetail getExpressionWithCIdOrLink:cId app:app Success:^(CommentExpression *expre) {
            [weakSelf changeButtonTitleWith:expre];
        }];
    }else{
        [RequestContentDetail getExpressionWithCIdOrLink:cId app:app Success:^(CommentExpression *expre) {
            [weakSelf changeButtonTitleWith:expre];
        }];
    }
}

/**改变表情按钮的title**/
-(void)changeButtonTitleWith:(CommentExpression *)ex
{
    
    double tit = 0;
    for (int i=0; i<3; i++) {
        UIButton *bu = expressiones[i];
        switch (i) {
            case 0:
                tit = ex.data.wowCount;
                break;
            case 1:
                tit = ex.data.zzzCount;
                break;
            case 2:
                tit = ex.data.wtfCount;
                break;
            default:
                break;
        }
        if (tit>0) {
            NSString *title = [NSString stringWithFormat:@"%0.0f",tit];
            NSLog(@"tit===%@",title);
            [bu setTitle:title forState:UIControlStateNormal];
        }
        
        
    }
}

/**添加假工具栏**/
-(void)addToolbar
{
    NSArray *strs = @[@"wow",@"zzz",@"wtf"];
    UIView *bottomView = [[UIView alloc]init];
    [self.view addSubview:bottomView];

    bottomView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .heightIs(BARHEIGHT);
    
    UILabel *line = [[UILabel alloc]init];
    [bottomView addSubview:line];
    line.backgroundColor = [UIColor lightGrayColor];
    line.sd_layout
    .leftSpaceToView(bottomView,0)
    .topSpaceToView(bottomView,0)
    .rightSpaceToView(bottomView,0)
    .heightIs(0.5);
    
    UIButton *share = [[UIButton alloc]init];
    [bottomView addSubview:share];
    share.sd_layout
    .centerYEqualToView(bottomView)
    .rightSpaceToView(bottomView,10)
    .widthIs(40)
    .heightEqualToWidth();
    [share setBackgroundImage:[UIImage imageNamed:@"content_shareIconBlack_highlighted.png"] forState:UIControlStateNormal];
    [share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGFloat margin = 10*WIDTHMULTIPLE;
    CGFloat w = 50;
    CGFloat hei = 20;
    CGFloat y = (bottomView.frame.size.height - hei)*0.5;
    for (int i=0; i<3; i++) {
        UIButton *button = [[UIButton alloc]init];
//        button.backgroundColor = [UIColor redColor];
        [bottomView addSubview:button];
        [expressiones addObject:button];
        button.tag = i+100;
        int h = i%3;
        CGFloat x = margin+(w+margin)*h;
        button.frame = CGRectMake(x, y, w, hei);
        NSString *imageName = [NSString stringWithFormat:@"ar_%d.png",i];
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        //button图片的偏移量，距上左下右分别(10, 10, 10, 60)像素点
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
        [button addTarget:self action:@selector(changeExpression:) forControlEvents:UIControlEventTouchUpInside];
        NSString *title = strs[i];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //button标题的偏移量，这个偏移量是相对于图片的
        button.titleEdgeInsets = UIEdgeInsetsMake(10, -10, 0, 0);
        button.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    
}

/**改变表情视图*/
-(void)changeExpression:(UIButton *)button
{
    NSLog(@"改变表情视图");
    int tag = button.tag - 100;
    NSString *type = [NSString stringWithFormat:@"%d",tag];
    isCancel = [canceles[tag] boolValue];
    if (isCancel) {
        [self cancelExpressionWithType:type];
    }else{
        [self commitExpressionWithType:type];
    }
    
    
    
}

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

/**取消表情*/
-(void)cancelExpressionWithType:(NSString *)type
{
    BOOL isOne = self.contentDetail.isOne;
    NSString *app = @"2";
    if (isOne) {
        app = @"1";
    }
    __weak ContentdetailViewController *weakSelf = self;
    [RequestCommendExpression cancelCommendExpressiontWithCid:self.contentDetail.data.contents.cid app:app type:type Success:^(BOOL success) {
        if (success) {
            isCancel = !isCancel;
            [canceles replaceObjectAtIndex:[type intValue] withObject:[NSNumber numberWithBool:isCancel]];
            [weakSelf getExpression];
        }
    }];
}

/**提交表情**/
-(void)commitExpressionWithType:(NSString *)type
{
    BOOL isOne = self.contentDetail.isOne;
    NSString *app = @"2";
    if (isOne) {
        app = @"1";
    }
    __weak ContentdetailViewController *weakSelf = self;
    [RequestCommendExpression postCommendExpressiontWithCid:self.contentDetail.data.contents.cid app:app type:type Success:^(BOOL success) {
        if (success) {
            isCancel = !isCancel;
            [canceles replaceObjectAtIndex:[type intValue] withObject:[NSNumber numberWithBool:isCancel]];
            [weakSelf getExpression];
        }
    }];
}


/**使用第三方富文本展示html**/
-(void)useRichText
{
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self.contentDetail.data.contents.content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSAttributedString *attributedString = [[NSAttributedString alloc]initWithHTMLData:data documentAttributes:nil];
    dtTextView.attributedString = attributedString;
    dtTextView.frame = CGRectMake(0, BARHEIGHT, WIDTH, HEIGHT-BARHEIGHT*3);
    [self.view addSubview:dtTextView];
}


/**添加简单的WebView*/
-(void)addEasyWebView
{
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, BARHEIGHT, WIDTH, HEIGHT-BARHEIGHT)];
    web.delegate = self;
    web.scalesPageToFit = YES;//尺度页面适合
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.contentDetail.data.contents.publishURL]]];
    [self.view addSubview:web];}

/**添加htmlwebView*/
-(void)addWebView
{
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, BARHEIGHT, WIDTH, HEIGHT-BARHEIGHT*2)];
    web.delegate = self;
    web.scrollView.delegate = self;
    web.scalesPageToFit = YES;//尺度页面适合
   
    
    ContentEImages *images = self.contentDetail.data.contents.images[0];
    
    
    NSString *topDivStr = [NSString stringWithFormat:@"<img style=\"margin:0;border:0;width:%fpx;height:%fpx;\" src=\"%@\"/><div style=\"font-size:16px;font-weight:bold;line-height:26px;word-wrap:break-word; margin-top:10px\">%@</div><div style=\"margin-top:10px;font-size:16px;font-weight:bold;\">%@</div><div style=\"margin-top:10px;\">",WIDTH*3,HEIGHT*1.5,images.url,self.contentDetail.data.contents.title,self.contentDetail.data.contents.subtitle];
    
//    NSString *bottmDivStr = [NSString stringWithFormat:@"<div style=\"font-size:16px;font-weight:bold;line-height:26px;word-wrap:break-word; margin-top:60px\">%@</div>",@"相关推荐"];
    
//    NSString *htmlStr = [NSString stringWithFormat:@"%@%@%@",topDivStr,self.contentDetail.data.contents.content,bottmDivStr];
    NSString *htmlStr = [NSString stringWithFormat:@"%@%@",topDivStr,self.contentDetail.data.contents.content];
    
    [web loadHTMLString:htmlStr baseURL:nil];
    [self.view addSubview:web];
}


#pragma mark===返回主页
/**返回主页**/
-(void)backMian
{
    if (_isSearch) {
        //
        SearchViewController *search = [[SearchViewController alloc]init];
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:search ] animated:YES];
    }else
    {
        MainViewController *main = [[MainViewController alloc]init];
        main.selectChannel = self.selectChannel;
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:main ] animated:YES];
    }
    
}

#pragma mark===UIWebViewDelegate
/**
 1、UIWebView设置字体大小，颜色，字体：1、UIWebView设置字体大小，颜色，字体：
 UIWebView无法通过自身的属性设置字体的一些属性，只能通过html代码进行设置，代码如下：UIWebView无法通过自身的属性设置字体的一些属性，只能通过html代码进行设置，代码如下：
 在webView加载完毕后，在- (void)webViewDidFinishLoad:(UIWebView *)webView方法中加入js代码
 **/
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//    CGFloat fontSize = 100.0;
//    NSString *fontSize = @"50px";
//    NSString *fontColor = @"'red'";
    NSString *firstWayJSStr = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '350%';";
//    NSString *secondWayJSStr = [NSString stringWithFormat:@"document.body.style.fontSize=%f;document.body.style.color=%@",fontSize,fontColor];
    
    [webView stringByEvaluatingJavaScriptFromString:firstWayJSStr];
}


#pragma mark===UIScrollViewDelegate
/**实现在开始位置和到底部的时候只能上推不能下拉**/
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGSize size = scrollView.contentSize;
//    NSLog(@"--sh-%f++++==%f",size.height,scrollView.contentOffset.y);
    CGFloat y = scrollView.contentOffset.y;
    if (y<=0) {
        [scrollView setContentOffset:CGPointZero animated:NO];
        
    }
    if (y>=size.height-scrollView.frame.size.height) {
        [scrollView setContentOffset:CGPointMake(0, size.height-scrollView.frame.size.height) animated:NO];
    }
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
