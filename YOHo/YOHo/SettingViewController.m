//
//  SettingViewController.m
//  YOHo
//
//  Created by mac on 16/3/30.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "SettingViewController.h"
#import "Data.h"
#import <RESideMenu.h>
#import "MainViewController.h"
#import "LanguageTableViewController.h"
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

#pragma mark ===初始化UI
/**初始化UI**/
-(void)initUI
{
    self.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backMian)];
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, BARHEIGHT, WIDTH, HEIGHT-BARHEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:table];
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
}

/**返回Main*/
#pragma mark ===返回Main
-(void)backMian
{
    MainViewController *main = [[MainViewController alloc]init];
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:main];
    [self.sideMenuViewController setContentViewController:na animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}


#pragma mark ===UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 5;
    }else if (section == 2){
        return 3;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            return 10;
        }else{
            return 35*HEIGHTMULTIPLE;
        }
    }else if (indexPath.section == 1){
    
        if (indexPath.row == 4) {
            return 10;
        }else if (indexPath.row == 1){
            return 40*HEIGHTMULTIPLE;
        }else{
            return 35*HEIGHTMULTIPLE;
        }
    }else if (indexPath.section == 2){
    
        if (indexPath.row == 2) {
            return 10;
        }else{
            return 35*HEIGHTMULTIPLE;
        }
        
    }else{
        return 125*HEIGHTMULTIPLE;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell = [cell initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:
            //2行
        {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"选择语言";
                
                cell.detailTextLabel.text = @"简体中文";
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else{
                cell.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.6];
            }
        }
            break;
        case 1:
            //5行
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"自动下载";
                    UISwitch *downLoadSwith = [[UISwitch alloc]init];
                    [downLoadSwith addTarget:self action:@selector(setAutodownload:) forControlEvents:UIControlEventValueChanged];
                    cell.accessoryView = downLoadSwith;
                
                }
                    break;
                case 1:
                {
                cell.textLabel.text = @"  用户仅wifi下可用自动下载最新内容";
                    cell.textColor = [UIColor lightGrayColor];
                    cell.font = [UIFont systemFontOfSize:10];
                }
                    break;
                case 2:
                {
                    cell.textLabel.text = @"推送设置";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                    break;
                case 3:
                {
                    cell.textLabel.text = @"清除缓存";
                    
                    cell.detailTextLabel.text = @"0.0M";
                }
                    break;
                case 4:
                    cell.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.6];
                    break;
                default:
                    break;
            }
        }
            break;

        case 2:
            //3行
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"意见反馈";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }

                    break;
                case 1:
                {
                    cell.textLabel.text = @"关于我们";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }

                    break;
                case 2:
                    cell.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.6];
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 3:
            //1行
        {
            UIView *view = [self setLastCellViewWithBounds:cell.bounds];
            [cell.contentView addSubview:view];
        }
            break;

            
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                //选择语言
                LanguageTableViewController *language = [[LanguageTableViewController alloc]init];
                [self pushView:language];
            }
        }
            break;
        case 1:
        {
            if (indexPath.row == 2) {
                //推送设置
            }
            if (indexPath.row == 3) {
                //清除缓存
            }
        }
            break;
        case 2:
        {
            if (indexPath.row == 0) {
                //意见反馈
            }
            if (indexPath.row == 1) {
                //关于我们
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark==pushView
/**pushView*/
-(void)pushView:(UIViewController *)vc
{
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:vc] animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}

#pragma mark==设置底部自定义的cell的View
/**设置底部自定义的cell的View**/
-(UIView *)setLastCellViewWithBounds:(CGRect)bounds
{
    UIView *view = [[UIView alloc]initWithFrame:bounds];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, view.frame.size.width*0.6, 25)];
    label.text = @"更多应用";
    [view addSubview:label];
    
    CGFloat vW = WIDTH/11;
    
    NSArray *images = @[@"buy",@"show",@"market"];
    NSArray *names = @[@"YOHO!有货",@"SHOW",@"MARS"];
    
    for (int i=0; i<3; i++) {
        UIButton *appButton = [[UIButton alloc]init];
        int h = i%3;
        CGFloat x = vW+(vW +2*vW+vW/3)*h;
        appButton.frame = CGRectMake(x, label.frame.size.height+10, 2*vW+vW/3, 2*vW+vW/3);
        appButton.tag = 300+i;
        [appButton setBackgroundImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [appButton addTarget:self action:@selector(goToAppStore:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:appButton];
        
        UILabel *appName = [[UILabel alloc]init];
        appName.frame = CGRectMake(x, appButton.frame.size.height+appButton.frame.origin.y+5, appButton.frame.size.width, 15);
        appName.text = names[i];
        appName.textAlignment = UITextAlignmentCenter;
        appName.adjustsFontSizeToFitWidth = YES;
        [view addSubview:appName];
    }
    return view;
}

#pragma mark==设置自动下载
/**设置自动下载*/
-(void)setAutodownload:(UISwitch *)swi
{
    NSLog(@"设置自动下载");
}

#pragma mark==点击app的图标
/**点击app的图标*/
-(void)goToAppStore:(UIButton *)button
{
    NSLog(@"%d",button.tag);
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
