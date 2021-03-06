//
//  TypeViewController.m
//  YOHo
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "TypeViewController.h"
#import "Data.h"
#import "CustomizationNavBar.h"
#import "JudgeLoginClass.h"
#import "RequestChannelInfo.h"
#import <RESideMenu.h>
#import "MainViewController.h"
#import "LoginViewController.h"
#import "SettingViewController.h"
#import "ScanCodeViewController.h"
#import "SearchViewController.h"
#import "JudgeLoginClass.h"
#import <UIButton+WebCache.h>
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
@interface TypeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TypeViewController
{
    NSMutableDictionary *chanDic;
    NSArray *textArray;
    NSArray *channelArray;
    BOOL isLogin;
    NSString *titleString;
    CustomizationNavBar *navBar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    isLogin = NO;
    textArray = @[@"NEW 最新",@"BOYS 男生资讯",@"GIRLS 女生资讯",@"VIDEO 视频",@"FEATURE 专题",@"MAGAZINE 杂志",@"WALLPAPER 壁纸"];
    channelArray = @[@"最新",@"男生资讯",@"女生资讯",@"视频",@"专题",@"杂志",@"壁纸"];
//    chanDic = [[NSMutableDictionary alloc]init];
//    [RequestChannelInfo getChannelArraySuccess:^(NSMutableDictionary *channelDic) {
//        chanDic = channelDic;
//    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    isLogin = [JudgeLoginClass isLogin];
    [self initUI];
}

/**初试化UI*/
-(void)initUI
{
    //创建假导航
//    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
//    navView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:navView];
    
    
    navBar = [[CustomizationNavBar alloc]init];
    
    navBar.leftButton = [[UIButton alloc]init];
    [navBar.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   
    
    
    if (isLogin) {
        NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
        NSString *nickname = [us objectForKey:@"nickname"];
        NSString *icon = [us objectForKey:@"icon"];
       //        [navBar.leftButton setImage:image forState:UIControlStateNormal];
        [navBar.leftButton sd_setImageWithURL:[NSURL URLWithString:icon] forState:UIControlStateNormal];
        titleString =nickname;
    }else{
        titleString = @"您还未登陆账号，请点击登录";
        [navBar.leftButton setImage:[UIImage imageNamed:@"userPic"] forState:UIControlStateNormal];
    }

    [navBar.leftButton setTitle:titleString forState:UIControlStateNormal];
    [navBar.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    navBar.enableContentViewTap = YES;
    [self.view addSubview:navBar];

    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    table.rowHeight = 50;
    table.scrollEnabled = NO;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    [self addBottomView];
    
    
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
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, BARHEIGHT-0.5, WIDTH, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [barView addSubview:line];
    
    [barView addSubview:leftButton];
    [self.view addSubview:barView];
}


/**添加底部按钮栏*/
-(void)addBottomView
{
    UIView *bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-64, WIDTH, 64)];
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(1, 0, WIDTH, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview: line];
    NSArray *array = @[@"搜索",@"扫描",@"下载",@"设置"];
    for (int i=0; i<4; i++) {
        UIButton *button = [[UIButton alloc]init];
        int y = i%4;
        CGFloat x = 20+(30+30*WIDTHMULTIPLE)*y;
        button.frame = CGRectMake(x, 10, 30, 44);
        button.tag = 100+i;
        button.font = [UIFont systemFontOfSize:15];
        NSString *str = array[i];
        [button setTitle:str forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:button];
    }
    
    [self.view addSubview:bottomView];
}

/**底部按钮被点击*/
-(void)bottomButtonClick:(UIButton *)button
{
    NSLog(@"%ld",(long)button.tag);
    
    switch (button.tag) {
        case 100:
            //搜索
        {
            SearchViewController *search = [[SearchViewController alloc]init];
            [self goToOtherViewControll:search];
        }
            break;
        case 101:
            //扫描
        {
            ScanCodeViewController *scan = [[ScanCodeViewController alloc]init];
            [self goToOtherViewControll:scan];
        }
            break;
        case 102:
            //下载
            break;
        case 103:
            //设置
        {
            SettingViewController *setting = [[SettingViewController alloc]init];
            [self goToOtherViewControll:setting];
        }
            
            break;
            
        default:
            break;
    }
    
}

/**前往下一个页面**/
-(void)goToOtherViewControll:(UIViewController *)vc
{
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES];
    [self.sideMenuViewController hideMenuViewController];

}

/**点击登录*/
-(void)leftButtonClick:(UIButton *)button
{
    NSLog(@"登录");
    if (isLogin) {
        //
        UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"确定要退出YOHO！" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *queDing = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //退出
            SSEBaseUser *user = [SSEThirdPartyLoginHelper currentUser];
            [SSEThirdPartyLoginHelper logout:user];
            
            
                NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
                [us removeObjectForKey:@"token"];
                [us removeObjectForKey:@"uid"];
                [us removeObjectForKey:@"icon"];
                [us removeObjectForKey:@"nickname"];
                [us synchronize];
                titleString = @"您还未登陆账号，请点击登录";
                [navBar.leftButton setImage:[UIImage imageNamed:@"userPic"] forState:UIControlStateNormal];
                [navBar.leftButton setTitle:titleString forState:UIControlStateNormal];
                isLogin = NO;

            
        }];
        [alter addAction:cancel];
        [alter addAction:queDing];
        [self presentViewController:alter animated:YES completion:nil];
        
    }else{
        LoginViewController *login = [[LoginViewController alloc]init];
        
        [self presentViewController:login animated:YES completion:nil];
    }
    
    
//    [self backMianWitnChannel:@"最新"];
}

#pragma mark == 退出第三方



#pragma mark == tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = textArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *channel = channelArray[indexPath.row];
    /**返回Mian*/
    [self backMianWitnChannel:channel];
//    MainViewController *main = [[MainViewController alloc]init];
//    main.selectChannel = channel;
//    main.selectedIndex = (int)indexPath.row;
//    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:main];
//    [self.sideMenuViewController setContentViewController:na animated:YES];
//    [self.sideMenuViewController hideMenuViewController];
}

/**返回Main*/
-(void)backMianWitnChannel:(NSString *)channel
{
    MainViewController *main = [[MainViewController alloc]init];
    main.selectChannel = channel;
//    main.selectedIndex = (int)indexPath.row;
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:main];
    [self.sideMenuViewController setContentViewController:na animated:YES];
    [self.sideMenuViewController hideMenuViewController];
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
