//
//  SelectCountryViewController.m
//  YOHo
//
//  Created by mac on 16/3/30.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "SelectCountryViewController.h"
#import "Data.h"
#import "LoginViewController.h"
@interface SelectCountryViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SelectCountryViewController
{
    
    NSArray *datas;
    NSString *coun;
    int selectRow;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    datas = @[@"澳大利亚",@"韩国",@"加拿大",@"马来西亚",@"美国",@"日本",@"新加坡",@"英国",@"中国",@"中国澳门",@"中国台湾",@"中国香港"];
    [self initUI];
}

/**初始化UI**/
-(void)initUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.6];
    self.navigationController.navigationBar.hidden = YES;
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, BARHEIGHT)];
    barView.backgroundColor = [UIColor clearColor];
    
    
    UIButton *backButton = [[UIButton alloc]init];
    backButton.center = CGPointMake(barView.frame.origin.x+25, barView.center.y+11);
    backButton.bounds =CGRectMake(0, 0, 30, 30);
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.center = CGPointMake(barView.center.x, backButton.center.y);
    titleLabel.bounds = CGRectMake(0, 0, barView.frame.size.width*0.6,barView.frame.size.height*0.4);
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.text = @"选择国家";
    titleLabel.textColor = [UIColor whiteColor];
    [barView addSubview:titleLabel];
    
    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, BARHEIGHT, WIDTH, HEIGHT-BARHEIGHT)];
//    table.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.6];
    table.rowHeight = table.frame.size.height/datas.count;
    table.scrollEnabled = NO;
    table.separatorColor = [UIColor whiteColor];
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    [self.view addSubview:barView];
}


/**返回**/
-(void)back:(UIButton *)button
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)getSelectedInfo:(Selected)select
{
    self.selectBlock = select;
}

#pragma mark == UItableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.6];
    cell.textLabel.text = datas[indexPath.row];
    return cell;
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    coun = datas[indexPath.row];
    selectRow = indexPath.row;
    
    
//    login.selectCountry = coun;
//    login.selectedRow = selectRow;
    [self.navigationController popToRootViewControllerAnimated:YES];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (coun != nil) {
        if (self.selectBlock != nil) {
            self.selectBlock(coun,selectRow);
        }
        
    }
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
