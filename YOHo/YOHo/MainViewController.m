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
#import "ContentView.h"
#import <SDCycleScrollView.h>
#import "ContentTableViewController.h"
#import "RequestContentInfo.h"
#import "ContentDetailTableViewController.h"
@interface MainViewController ()<SDCycleScrollViewDelegate,UIScrollViewDelegate,ContentTableViewControllerDelegate>

@end

@implementation MainViewController
{
    NSMutableArray *largeBanners;
    NSMutableArray *banners;
    UIScrollView *contentScrollView;
    NSString *titleStr;
    /**被选中的id*/
    NSString *channelId;
    NSMutableArray *markButtons;
    NSMutableArray *contentVCs;
    int selectedMark;
    UILabel *markLine;
    UILabel *spLabel;
    CGFloat sH;//顶部scrollView的高度
    UIScrollView *markScrollView;
    NSMutableArray *channelIds;//id数值
    int tag;//应该显示的ViewControll
    
}
-(id)init
{
    self = [super init];
    if (self) {
        sH = 0;
        selectedMark = 0;
        _selectChannel = @"最新";
       contentVCs = [[NSMutableArray alloc]init];
       markButtons = [[NSMutableArray alloc]init];
        channelIds = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self getChanelData];
    
   
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication].delegate window].rootViewController = self.sideMenuViewController;
    [self initUI];
    
}



#pragma mark ===获取chanel数据
/**获取chanel数据*/
-(void)getChanelData
{
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);//信号量
    
    __weak MainViewController *weakSelf = self;
    [RequestChannelInfo getChannelArraySuccess:^(NSMutableDictionary *channelDic) {

        NSArray *channel = [channelDic objectForKey:_selectChannel];
        
        _scrollArray = channel[0];
        
        channelIds = channel[2];//id数组
        channelId = channel[3];//默认选中第0个
        NSLog(@"00000");
        
        if (_scrollArray.count>0) {
            NSLog(@"22222");
            [weakSelf addTopScrollView];
            [weakSelf addContentScrollView];
        }
        //将所有的banner取出来装到数组里largebanners
//        for (NSString *chId in channelIds) {
//             [weakSelf getBannerDataWithChannelId:chId];
//            NSLog(@"11111");
//        }
        
        //发出已完成的信号
//        dispatch_semaphore_signal(semaphore);
    }];
    
    //等待执行，不会占用资源
//    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    
    
}

#pragma mark ===获取轮播的数据
/**获取轮播的数据*/
-(void)getBannerDataWithChannelId:(NSString *)channId
{

    [RequestBannerInfo getBannerLinkAndImageWithChannelId:channId Success:^(NSMutableArray *bannerArray) {
        [largeBanners addObject:bannerArray];
//        for (BannerClass *banner in bannerArray) {
//            NSLog(@"------%@",banner.link);
//        }
    
        ContentTableViewController *con = contentVCs[tag];
        con.banners = bannerArray;
    }];
}

#pragma mark ===获取表的数据
/**获取表的数据*/
-(void)getContentDataWithChannelId:(NSString *)channId
{
    NSLog(@"mark=====%@",channId);
    
    [RequestContentInfo getContentinfoWithChannelId:channId Success:^(NSMutableArray *contentArray) {
        
        for (ContentClass *co in contentArray) {
            NSLog(@"====%@",co.title);
        }
        
        ContentTableViewController *con = contentVCs[tag];
        con.contents = contentArray;

    }];
}

#pragma mark===初始化UI
/**初始化UI*/
-(void)initUI
{
    self.navigationController.navigationBar.hidden = YES;
    [self addBar];

}

#pragma mark===添加假导航
/**添加假导航*/
-(void)addBar
{
    
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    barView.backgroundColor = [UIColor whiteColor];
    
    UIButton *leftButton = [[UIButton alloc]init];
    leftButton.center = CGPointMake(20+17.5, barView.center.y+5);
    leftButton.bounds = CGRectMake(0, 0, 35, 35);
    
    [leftButton setBackgroundImage:[UIImage imageNamed:@"navIcon"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(goToTypeVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *midlleButton = [[UIButton alloc]init];
    midlleButton.center = CGPointMake(barView.center.x, leftButton.center.y);
    midlleButton.bounds = CGRectMake(0, 0, barView.frame.size.width*0.6, barView.frame.size.height*0.7);
    [midlleButton setTitle:_selectChannel forState:UIControlStateNormal];
    [midlleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, BARHEIGHT-0.5, WIDTH, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [barView addSubview:line];
    
    [barView addSubview:midlleButton];
    [barView addSubview:leftButton];
    
    
    [self.view addSubview:barView];
}


#pragma mark===添加主要scrollView
/**添加主要scrollView*/
-(void)addContentScrollView
{
    CGFloat contentScrollViewH = (HEIGHT-BARHEIGHT-sH)*HEIGHTMULTIPLE;
    contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, BARHEIGHT+sH, WIDTH, contentScrollViewH)];
    contentScrollView.backgroundColor = [UIColor whiteColor];
    contentScrollView.pagingEnabled = YES;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.contentSize = CGSizeMake(WIDTH*_scrollArray.count, contentScrollViewH);
    contentScrollView.delegate = self;
    [self.view addSubview:contentScrollView];
    
    for (int i=0; i<_scrollArray.count; i++) {
        
        ContentTableViewController *content = [[ContentTableViewController alloc]init];
        content.delegate = self;
        int x = i%_scrollArray.count;
        
        CGRect frame = CGRectMake(x*WIDTH, 0, WIDTH, contentScrollView.frame.size.height);
        content.view.frame = frame;
        
        NSLog(@"====la===%d",largeBanners.count);
        content.banners = largeBanners[i];
//        content.view.backgroundColor = [UIColor redColor];
        [contentVCs addObject:content];
        [contentScrollView addSubview:content.view];
    }
    
    

}


#pragma mark===添加添加主要内容
/**添加主要内容*/
-(UITableView *)addContentViewWithFram:(CGRect)frame
{
    UITableView *table = [[UITableView alloc]initWithFrame:frame];
    table.tableHeaderView = [self setTableHeaderView];
    return table;
}

#pragma mark== 设置表头
-(SDCycleScrollView *)setTableHeaderView
{
    
    NSMutableArray *imageUrls = [[NSMutableArray alloc]init];
    for (BannerClass *banner in banners) {
        NSString *url = banner.image;
        [imageUrls addObject:url];
    }
    
    SDCycleScrollView *cycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH, 150*HEIGHTMULTIPLE) delegate:self placeholderImage:nil];
    cycle.imageURLStringsGroup = imageUrls;
    cycle.showPageControl = YES;
    cycle.delegate = self;
    
    return cycle;
    
}

#pragma mark++++添加轮播视图
/**添加轮播视图*/
-(SDCycleScrollView *)addCycleScrollView
{
    NSMutableArray *imageUrls = [[NSMutableArray alloc]init];
    for (BannerClass *banner in largeBanners) {
        NSString *url = banner.image;
        [imageUrls addObject:url];
    }
    
    SDCycleScrollView *cycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH, 150*HEIGHTMULTIPLE) delegate:self placeholderImage:nil];
    cycle.imageURLStringsGroup = imageUrls;
    cycle.showPageControl = YES;
    cycle.delegate = self;
    return cycle;
}

#pragma mark==SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"点击SDCycleScrollView");
}



#pragma mark===添加顶部的scrollView及scrollView的上的标签按钮
/**添加顶部scrollView*/
-(void)addTopScrollView
{
    int spaceToleft = 20;//距离屏幕左边的距离
    int betweenSpace = 50;//markbutton之间的距离
    sH = 30*HEIGHTMULTIPLE;//scrollView的高度
    markScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, BARHEIGHT, WIDTH, sH)];
    markScrollView.showsHorizontalScrollIndicator = NO;
    markScrollView.backgroundColor = [UIColor whiteColor];
    CGFloat wid = 50*WIDTHMULTIPLE;//按钮的宽度
    CGFloat scConWidth = spaceToleft +(wid+50)*self.scrollArray.count;//scrollVIew的容量宽度
    markScrollView.contentSize = CGSizeMake(scConWidth, sH);
    [self.view addSubview:markScrollView];
    
    
    spLabel = [[UILabel alloc]init];
    spLabel.backgroundColor = [UIColor whiteColor];
    spLabel.textAlignment = UITextAlignmentCenter;
    [markScrollView addSubview:spLabel];
    markLine = [[UILabel alloc]init];
    markLine.backgroundColor = [UIColor purpleColor];
    [markScrollView addSubview:markLine];
    
    
    for (int i=0; i<self.scrollArray.count; i++) {
        UIButton *markButton = [[UIButton alloc]init];
        int h = i%self.scrollArray.count;
        
        CGFloat x = spaceToleft+(wid+betweenSpace)*h;
        markButton.tag = 300+i;
        markButton.frame = CGRectMake(x, 0, wid, sH);
        
        if (i == selectedMark) {
            [self selectedMrak:markButton];//默认选中第一个按钮
        }
        [markButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        
        [markButton setTitle:_scrollArray[i] forState:UIControlStateNormal];
        [markButton addTarget:self action:@selector(selectedMrak:) forControlEvents:UIControlEventTouchUpInside];
        [markButtons addObject:markButton];
        [markScrollView addSubview:markButton];
    }
}

#pragma mark===点击scrollVIew上的标签按钮
/**点击scrollVIew上的标签按钮**/
-(void)selectedMrak:(UIButton *)mark
{
    NSLog(@"点击scrollVIew上的标签按钮==$%d",mark.tag);
    markLine.center = CGPointMake(mark.center.x, mark.frame.size.height*0.9);
    markLine.bounds = CGRectMake(0, 0, mark.frame.size.width, 1);
    spLabel.center = mark.center;
    spLabel.bounds = mark.bounds;
    spLabel.textColor = [UIColor purpleColor];
    spLabel.text = _scrollArray[mark.tag-300];
    
    tag = mark.tag - 300;
    
    CGFloat offSetX = tag*WIDTH;
    contentScrollView.contentOffset = CGPointMake(offSetX, 0);
    NSLog(@"channelId====%@",channelIds[tag]);
    [self getBannerDataWithChannelId:channelIds[tag]];
    [self getContentDataWithChannelId:channelIds[tag]];
}

#pragma mark ==UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int x = (int)scrollView.contentOffset.x/WIDTH;
    NSLog(@"====%d",x);
    UIButton *button = markButtons[x];
    markScrollView.contentOffset = CGPointMake(button.frame.origin.x-20, 0);
    [self selectedMrak:button];
}




#pragma mark===前往分类页面
/**前往分类页面*/
-(void)goToTypeVC
{
    [self.sideMenuViewController presentLeftMenuViewController];
}

#pragma mark==ContentTableViewControllerDelegate
-(void)contentGetContentDetail:(ContentENSObject *)contentDetail
{
    ContentDetailTableViewController *detail = [[ContentDetailTableViewController alloc]init];
    detail.contentDetail = contentDetail;
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:detail] animated:YES];
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
