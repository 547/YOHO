//
//  MainViewController.m
//  YOHo
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "MainViewController.h"
#import "TypeViewController.h"
#import <UIViewController+RESideMenu.h>
#import <RESideMenu.h>
#import "CustomizationNavBar.h"
#import "RequestChannelInfo.h"
#import "RequestBannerInfo.h"
#import "BannerClass.h"
#import "Data.h"
#import "ContentViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController
{
    NSString *titleStr;
    NSString *channelId;
}
-(id)init
{
    self = [super init];
    if (self) {
        _selectChannel = @"最新";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getChanelData];
    
   
}

/**获取chanel数据*/
-(void)getChanelData
{
    [RequestChannelInfo getChannelArraySuccess:^(NSMutableDictionary *channelDic) {

        NSArray *channel = [channelDic objectForKey:_selectChannel];
        
        _scrollArray = channel[0];
        channelId = channel[2];
        NSLog(@"id===%@",channelId);
//        for (NSString *str in _scrollArray) {
//             NSLog(@"-=%@",str);
//        }
        
        [RequestBannerInfo getBannerLinkAndImageWithChannelId:channelId Success:^(NSMutableArray *bannerArray) {
            for (BannerClass *banner in bannerArray) {
                NSLog(@"------%@",banner.link);
            }
        }];
        
    }];
}

/**获取banner数据*/
-(void)getBannerData
{
    //http://new.yohoboys.com/yohoboyins/v4/channel/banner
   NSString *str = @"http://new.yohoboys.com/yohoboyins/v4/channel/banner?parameters=%7B%22channelId%22%3A%221-16%22%2C%22curVersion%22%3A%224.0.3%22%2C%22language%22%3A%22zh-Hans%22%7D";
    
    NSLog(@"----%@",[str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
[RequestBannerInfo getBannerLinkAndImageWithChannelId:channelId Success:^(NSMutableArray *bannerArray) {
    for (BannerClass *banner in bannerArray) {
//        NSLog(@"------%@",banner.link);
    }
}];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication].delegate window].rootViewController = self.sideMenuViewController;
    
    [self getBannerData];
    [self initUI];
    if (_selectedIndex>3) {
    //就是没有上面的scrollView的
        
    }else{
    //0-3是有上面的scrollView的
        
    }
    
}

//-(void)setSelectedIndex:(int)selectedIndex
//{
//   
//    _selectedIndex = selectedIndex;
//   
//    NSArray *valuesArray = chanDic.allValues;
//     NSLog(@"++2+++%@",valuesArray);
//    NSArray *channel = valuesArray[_selectedIndex];
//    _scrollArray = channel[0];
//    NSLog(@"+++++%@",_scrollArray);
//}


/**初始化UI*/
-(void)initUI
{
    self.navigationController.navigationBar.hidden = YES;
    //设置左边按钮
//    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navIcon"] style:UIBarButtonItemStyleDone target:self action:@selector(goToTypeVC)];
//    self.navigationItem.leftBarButtonItem = left;
   //设置左边按钮
    CustomizationNavBar *navBar = [[CustomizationNavBar alloc]init];
    UIButton *button = [[UIButton alloc]init];
    [button setBackgroundImage:[UIImage imageNamed:@"navIcon"]  forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goToTypeVC) forControlEvents:UIControlEventTouchUpInside];
    navBar.leftButton = button;
    
    navBar.titleLabel.text = @"";
    [self.view addSubview:navBar];
    
    [self pageViewController];
    
}


/**滑动翻页*/
-(void)pageViewController
{
   
//    [[UIApplication sharedApplication].delegate window].rootViewController = xt;
}

/**添加scrollView*/
-(void)addScrollView
{
    UIScrollView *scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 30)];
    
}









/**前往分类页面*/
-(void)goToTypeVC
{
    [self.sideMenuViewController presentLeftMenuViewController];
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
