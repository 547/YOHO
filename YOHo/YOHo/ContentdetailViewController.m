//
//  ContentdetailViewController.m
//  YOHo
//
//  Created by mac on 16/4/7.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ContentdetailViewController.h"

@interface ContentdetailViewController ()<UIWebViewDelegate,UIScrollViewDelegate>

@end

@implementation ContentdetailViewController
{
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
    
    [self addWebView];
    [self addToolbar];
    
    
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
