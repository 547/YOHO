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
#import "MagazineViewController.h"
#import "Data.h"
#import <SDCycleScrollView.h>
#import "ContentTableViewController.h"
#import "DataModels.h"
#import "RequestVideo.h"
#import "RequestMagazine.h"
#import "RequestWallPaper.h"
#import "WallPapersViewController.h"
#import "SingWallPaperViewController.h"
#import "ContentdetailViewController.h"
#import "ReadingMagazineViewController.h"
@interface MainViewController ()<SDCycleScrollViewDelegate,UIScrollViewDelegate,ContentTableViewControllerDelegate,MagazineViewControllerDelegate,WallPapersViewControllerDelegate>
@property(nonatomic,strong)ContentTableViewController *contentOther;
@property(nonatomic,strong)UIView *topButtonView;
@end

@implementation MainViewController
{
    NSMutableArray *magazineVCs;
    NSMutableArray *magazineButtons;
    UIScrollView *mScrollView;
    int selectedButton;
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
    UILabel *line;
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
       magazineButtons = [[NSMutableArray alloc]init];
        magazineVCs = [[NSMutableArray alloc]init];
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
        if ([_selectChannel isEqualToString:@"视频"]||[_selectChannel isEqualToString:@"专题"]) {
            NSLog(@"是视频和专题");
            [weakSelf getBannerDataWithChannelId:channelId];
            [weakSelf getContentDataWithChannelId:channelId];
        }
        if ([_selectChannel isEqualToString:@"杂志"]) {
            NSLog(@"是杂志");
            line.hidden = YES;
            [self.view addSubview:self.topButtonView];
            NSLog(@"%@",NSStringFromCGRect(_topButtonView.frame));
            [self addMagazineScrollView];
        }
        if ([_selectChannel isEqualToString:@"壁纸"]) {
            line.hidden = YES;
            NSLog(@"是壁纸");
            [self addWallPaper];
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


#pragma mark==添加壁纸视图

-(void)addWallPaper
{
    
    
    WallPapersViewController *wall = [[WallPapersViewController alloc]init];
    wall.view.frame = CGRectMake(0, BARHEIGHT, WIDTH, HEIGHT-BARHEIGHT);

    wall.delegate = self;
    [self.view addSubview:wall.view];
    /**
     View Controller中可以添加多个sub view，在需要的时候显示出来；
     
     可以通过viewController(parent)中可以添加多个child viewController;来控制页面中的sub view，降低代码耦合度；
     
     通过切换，可以显示不同的view；，替代之前的addSubView的管理
     **/
    [self addChildViewController:wall];

}

#pragma mark==懒加载视频等channel的ViewControll
/**ContentTableViewController的懒加载
 1.懒加载基本
 
 懒加载——也称为延迟加载，即在需要的时候才加载（效率低，占用内存小）。所谓懒加载，写的是其get方法.
 
 注意：如果是懒加载的话则一定要注意先判断是否已经有了，如果没有那么再去进行实例化
 
 2.使用懒加载的好处：
 
 （1）不必将创建对象的代码全部写在viewDidLoad方法中，代码的可读性更强
 
 （2）每个控件的getter方法中分别负责各自的实例化处理，代码彼此之间的独立性强，松耦合
 **/
-(ContentTableViewController *)contentOther
{
//判断是否已经有了，若没有，则进行实例化
    if (!_contentOther) {
        _contentOther = [[ContentTableViewController alloc]init];
        _contentOther.delegate = self;
        _contentOther.view.frame = CGRectMake(0, BARHEIGHT, WIDTH, HEIGHT-BARHEIGHT);
        [self.view addSubview:_contentOther.view];
    }
    return _contentOther;
    
}


/**添加杂志ScrollVIew*/
-(void)addMagazineScrollView
{
    mScrollView = [[UIScrollView alloc]init];
    CGFloat y = _topButtonView.frame.size.height+_topButtonView.frame.origin.y+20;
    mScrollView.frame = CGRectMake(0, y, WIDTH, HEIGHT-y);
    
    mScrollView.showsHorizontalScrollIndicator = NO;
    mScrollView.scrollEnabled = NO;
    mScrollView.contentOffset = CGPointMake(0, 0);
    [self.view addSubview:mScrollView];
    for (int i=0; i<3; i++) {
        MagazineViewController *ma = [[MagazineViewController alloc]init];
        ma.delegate = self;
        int h = i%3;
        CGFloat x = WIDTH*h;
        ma.view.frame = CGRectMake(x, 0, mScrollView.frame.size.width,mScrollView.frame.size.height);
        ma.type = i;
        [magazineVCs addObject:ma];
        [mScrollView addSubview:ma.view];
    }

}


#pragma mark==懒加载TopButtonView
/**TopButtonView**/
-(UIView *)topButtonView
{
    sH = 30*HEIGHTMULTIPLE;
    if (!_topButtonView) {
        _topButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, BARHEIGHT, WIDTH, sH)];
        _topButtonView.backgroundColor = [UIColor whiteColor];
        [self addTopButtonToView];
    }
    return _topButtonView;
}

#pragma mark ==杂志类型的按钮被选中
/**杂志类型的按钮被选中*/
-(void)selectEdMagazineMarkButton:(UIButton *)button
{
//上次点击的按钮
        UIButton *lastButton = magazineButtons[selectedButton];
        [lastButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        lastButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//本次点击的按钮
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.borderColor = [UIColor blackColor].CGColor;
    
    int rTag = button.tag-2000;
    mScrollView.contentOffset = CGPointMake(WIDTH*rTag, 0);
    
    if (rTag == 2) {
        MagazineViewController *m = magazineVCs[rTag];
        m.type = rTag;
    }
    
    selectedButton = rTag;
    
}



#pragma mark ===添加顶部button
/**添加顶部button*/
-(void)addTopButtonToView
{
    NSArray *titles = @[@"BOYS",@"GIRLS",@"MINE"];
    int count = titles.count;
    CGFloat leftSpace = 20;
    CGFloat betweenSpace = 25*WIDTHMULTIPLE;
    CGFloat wid = (WIDTH -(2*leftSpace+(count-1)*betweenSpace))/3;
    for (int i=0; i<count; i++) {
        UIButton *button = [[UIButton alloc]init];
        int h = i%count;
        

        
        CGFloat x = leftSpace+(betweenSpace+wid)*h;
        button.frame = CGRectMake(x, 1, wid, _topButtonView.frame.size.height-3);
        [_topButtonView addSubview:button];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        button.layer.borderWidth = 1.0;
        [button addTarget:self action:@selector(selectEdMagazineMarkButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 2000+i;
        [magazineButtons addObject:button];
        if (i == 0) {
            [self selectEdMagazineMarkButton:button];
        }
    }

    
}




#pragma mark ===获取轮播的数据
/**获取轮播的数据*/
-(void)getBannerDataWithChannelId:(NSString *)channId
{

    [RequestVideo getVideoBannersWithChannelId:channId Success:^(NSArray *videoBanners) {
        if ([_selectChannel isEqualToString:@"最新"]||[_selectChannel isEqualToString:@"男生资讯"]||[_selectChannel isEqualToString:@"女生资讯"]) {
            ContentTableViewController *con = contentVCs[tag];
            con.channelId = channId;
            con.banners = videoBanners;
        }
        if ([_selectChannel isEqualToString:@"视频"]||[_selectChannel isEqualToString:@"专题"]) {
            self.contentOther.banners = videoBanners;
        }


    }];
    
//    [RequestBannerInfo getBannerLinkAndImageWithChannelId:channId Success:^(NSMutableArray *bannerArray) {
//        [largeBanners addObject:bannerArray];
////        for (BannerClass *banner in bannerArray) {
////            NSLog(@"------%@",banner.link);
////        }
//    
//        ContentTableViewController *con = contentVCs[tag];
//        con.banners = bannerArray;
//    }];
}

#pragma mark ===获取表的数据
/**获取表的数据*/
-(void)getContentDataWithChannelId:(NSString *)channId
{
    NSLog(@"mark=====%@",channId);
    
    [RequestVideo getVideoSummeryWithChannelId:channId Success:^(NSArray *videoSummeries) {
        
        if ([_selectChannel isEqualToString:@"最新"]||[_selectChannel isEqualToString:@"男生资讯"]||[_selectChannel isEqualToString:@"女生资讯"]) {
            ContentTableViewController *con = contentVCs[tag];
            con.channelId = channId;
            con.contents = videoSummeries;
            
        }
        
        if ([_selectChannel isEqualToString:@"视频"]||[_selectChannel isEqualToString:@"专题"]) {
            self.contentOther.channelId = channId;
            self.contentOther.contents = videoSummeries;
        }
    }];
    
//    [RequestContentInfo getContentinfoWithChannelId:channId Success:^(NSMutableArray *contentArray) {
//        
//        for (ContentClass *co in contentArray) {
//            NSLog(@"====%@",co.title);
//        }
//        
//        ContentTableViewController *con = contentVCs[tag];
//        con.contents = contentArray;
//
//    }];
}

#pragma mark===初始化UI
/**初始化UI*/
-(void)initUI
{
    NSLog(@"44444++++++++++%@",NSHomeDirectory());
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    [self addBar];

}

#pragma mark===添加假导航
/**添加假导航*/
-(void)addBar
{
    
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, BARHEIGHT)];
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
   
        line = [[UILabel alloc]initWithFrame:CGRectMake(0, BARHEIGHT-0.5, WIDTH, 0.5)];
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
        [contentVCs addObject:content];
        [contentScrollView addSubview:content.view];
    }
    NSLog(@"con===%d",contentVCs.count);
    

}


#pragma mark===添加添加主要内容
/**添加主要内容*/
//-(UITableView *)addContentViewWithFram:(CGRect)frame
//{
//    UITableView *table = [[UITableView alloc]initWithFrame:frame];
//    table.tableHeaderView = [self setTableHeaderView];
//    return table;
//}

#pragma mark== 设置表头
//-(SDCycleScrollView *)setTableHeaderView
//{
//    
//    NSMutableArray *imageUrls = [[NSMutableArray alloc]init];
//    for (BannerClass *banner in banners) {
//        NSString *url = banner.image;
//        [imageUrls addObject:url];
//    }
//    
//    SDCycleScrollView *cycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH, 150*HEIGHTMULTIPLE) delegate:self placeholderImage:nil];
//    cycle.imageURLStringsGroup = imageUrls;
//    cycle.showPageControl = YES;
//    cycle.delegate = self;
//    
//    return cycle;
//    
//}

#pragma mark++++添加轮播视图
/**添加轮播视图*/
//-(SDCycleScrollView *)addCycleScrollView
//{
//    NSMutableArray *imageUrls = [[NSMutableArray alloc]init];
//    for (BannerClass *banner in largeBanners) {
//        NSString *url = banner.image;
//        [imageUrls addObject:url];
//    }
//    
//    SDCycleScrollView *cycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH, 150*HEIGHTMULTIPLE) delegate:self placeholderImage:nil];
//    cycle.imageURLStringsGroup = imageUrls;
//    cycle.showPageControl = YES;
//    cycle.delegate = self;
//    return cycle;
//}

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
    NSString *channel = channelIds[tag];
    NSLog(@"channelId====%@",channel);
    [self getBannerDataWithChannelId:channel];
    [self getContentDataWithChannelId:channel];
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

    ContentdetailViewController *detail = [[ContentdetailViewController alloc]init];
    detail.selectChannel = _selectChannel;
    detail.contentDetail = contentDetail;
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:detail] animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
}

-(void)contentShouldRefrshWithChannelId:(NSString *)chanId
{
    [self getBannerDataWithChannelId:chanId];
    [self getContentDataWithChannelId:chanId];
}

#pragma mark==MagazineViewControllerDelegate
-(void)magazineViewCGoToReadingMagazineWithSavePath:(MagazineData *)aMagazine
{

    
//    NSLog(@"前往阅读页-====%@",aMagazine);

    ReadingMagazineViewController *reading = [[ReadingMagazineViewController alloc]init];
    reading.magazine = aMagazine;
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:reading] animated:YES];
    
}

/**把下载好的保存到本地*/
-(void)saveMagazineToDataBase
{

}


#pragma mark==WallPapersViewControllerDelegate
/**点击图片获取图片的对象*/
-(void)wallPapersViewControllerGetClickedImage:(WallPapersImages *)image
{
    SingWallPaperViewController *singWallPaper = [[SingWallPaperViewController alloc]init];
    singWallPaper.image = image;
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:singWallPaper] animated:YES];
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
