//
//  ContentViewController.m
//  YOHo
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ContentViewController.h"

#import <SDCycleScrollView.h>
#import "Data.h"
#import "BannerClass.h"
@interface ContentViewController ()<SDCycleScrollViewDelegate>

@end

@implementation ContentViewController
{
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addCycleScrollView];
    [self addTableView];
}

/**添加轮播视图*/
-(void)addCycleScrollView
{
    NSMutableArray *imageUrls = [[NSMutableArray alloc]init];
    for (BannerClass *banner in _banners) {
        NSString *url = banner.image;
        [imageUrls addObject:url];
    }
    
    SDCycleScrollView *cycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH, 150) delegate:self placeholderImage:nil];
    cycle.imageURLStringsGroup = imageUrls;
    cycle.showPageControl = YES;
    cycle.delegate = self;
    [self.view addSubview:cycle];
}

#pragma mark==
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"点击SDCycleScrollView");
}

/**添加tableView*/
-(void)addTableView
{
//    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
//    table.rowHeight = 50;
//    table.scrollEnabled = NO;
//    table.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    table.delegate = self;
//    table.dataSource = self;
//    [self.view addSubview:table];
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
