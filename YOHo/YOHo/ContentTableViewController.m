//
//  ContentTableViewController.m
//  YOHo
//
//  Created by mac on 16/3/31.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ContentTableViewController.h"
#import <SDCycleScrollView.h>
#import "Data.h"
@interface ContentTableViewController ()<SDCycleScrollViewDelegate>

@end

@implementation ContentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self initUI];
}


-(void)setBanners:(NSMutableArray *)banners
{
    _banners = banners;
    self.tableView.tableHeaderView = [self setTableHeaderView];
}

#pragma mark==初始化UI
-(void)initUI
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}


#pragma mark== 设置表头
-(SDCycleScrollView *)setTableHeaderView
{

    NSMutableArray *imageUrls = [[NSMutableArray alloc]init];
    for (BannerClass *banner in _banners) {
        NSString *url = banner.image;
        [imageUrls addObject:url];
    }
    
    SDCycleScrollView *cycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH, self.view.frame.size.height*0.5) delegate:self placeholderImage:nil];
    cycle.imageURLStringsGroup = imageUrls;
    
    cycle.showPageControl = YES;
    cycle.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    cycle.delegate = self;
    
    return cycle;

}

#pragma mark==SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"点击SDCycleScrollView");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = @"4454";
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
