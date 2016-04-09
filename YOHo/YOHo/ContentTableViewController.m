//
//  ContentTableViewController.m
//  YOHo
//
//  Created by mac on 16/3/31.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ContentTableViewController.h"

@interface ContentTableViewController ()<SDCycleScrollViewDelegate>

@end

@implementation ContentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}


-(void)setBanners:(NSArray *)banners
{
    _banners = banners;
    self.tableView.tableHeaderView = [self setTableHeaderView];
}

-(void)setContents:(NSArray *)contents
{
    _contents = contents;
    [self.tableView reloadData];
}

#pragma mark==初始化UI
-(void)initUI
{
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MainTableViewCell class] forCellReuseIdentifier:@"cell"];

}


#pragma mark== 设置表头
-(SDCycleScrollView *)setTableHeaderView
{

    NSMutableArray *imageUrls = [[NSMutableArray alloc]init];

    for (BannerData *banner in _banners) {
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
    
    BannerData *ba = _banners[index];
    
//    BannerClass *ba = _banners[index];
    [self getContentDetailWithCIdOrLink:ba.link];
}

#pragma mark==请求详情数据
/**请求详情数据*/
-(void)getContentDetailWithCIdOrLink:(NSString *)cId
{

    __weak ContentTableViewController *weakSelf = self;
    
    [RequestContentDetail getContentDetailWithCIdOrLink:cId Success:^(ContentENSObject *contentDetail) {
        NSLog(@"-----%@",contentDetail);
        if (contentDetail.code == 400000) {
            [RequestContentDetail getContentDetailWithCIdOrLinkForApp1:cId Success:^(ContentENSObject *detail) {
                [weakSelf.delegate contentGetContentDetail:detail];
            }];
        }else{
        
        [weakSelf.delegate contentGetContentDetail:contentDetail];
        }
        
        //        UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
        //        [web loadHTMLString:contentDetail.data.contents.content baseURL:nil];
        //        [self.view addSubview:web];
    }];
}

#pragma mark==请求相关推荐数据
/**请求相关推荐数据*/
-(void)getRecommendSumWithCIdOrLink:(NSString *)cId
{
    
    __weak ContentTableViewController *weakSelf = self;

    
    
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

    return _contents.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoContent *content = _contents[indexPath.row];
//    ContentClass *content = _contents[indexPath.row];
    CGFloat height = [self.tableView cellHeightForIndexPath:indexPath model:content keyPath:@"contentModel" cellClass:[MainTableViewCell class] contentViewWidth:WIDTH];
    
    
    return 400;
    
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell != nil) {
        for (UIView *view in cell.subviews) {
            [view removeFromSuperview];
        }
    }
    cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.contentModel = _contents[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cId = nil;
   if (_isSearch) {
        SearchTWList *list = _contents[indexPath.row];
        cId = list.cid;
    }else{
        VideoContent *content = _contents[indexPath.row];
        //    ContentClass *content = _contents[indexPath.row];
        cId = content.cid;
    }
    [self getContentDetailWithCIdOrLink:cId];

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
