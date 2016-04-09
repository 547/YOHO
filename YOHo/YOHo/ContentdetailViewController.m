//
//  ContentdetailViewController.m
//  YOHo
//
//  Created by mac on 16/4/7.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ContentdetailViewController.h"
#import <NSAttributedString+HTML.h>
#import <DTAttributedTextView.h>
#import <UIView+SDAutoLayout.h>
#import "SearchViewController.h"
@interface ContentdetailViewController ()<UIWebViewDelegate,UIScrollViewDelegate>

@end

@implementation ContentdetailViewController
{
    DTAttributedTextView *dtTextView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}


#pragma mark===初始化UI
/**初始化UI*/
-(void)initUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"YOHO!";
 
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backMian)];
    
    [self addWebView];
    [self addToolbar];
//    [self useRichText];
    
    
}


/**添加假工具栏**/
-(void)addToolbar
{
    UIView *bottomView = [[UIView alloc]init];
    [self.view addSubview:bottomView];

    bottomView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .heightIs(BARHEIGHT);
    
//    for (int i=0; i; <#increment#>) {
//        <#statements#>
//    }
    
}

/**创建表情视图*/
-(void)createExpressionView
{

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
    
    NSString *bottmDivStr = [NSString stringWithFormat:@"<div style=\"font-size:16px;font-weight:bold;line-height:26px;word-wrap:break-word; margin-top:60px\">%@</div>",@"相关推荐"];
    
    NSString *htmlStr = [NSString stringWithFormat:@"%@%@%@",topDivStr,self.contentDetail.data.contents.content,bottmDivStr];
    
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
