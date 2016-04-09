//
//  SearchViewController.m
//  YOHo
//
//  Created by mac on 16/4/8.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "SearchViewController.h"
#import "DataModels.h"
#import "RequestSearch.h"
#import "ContentTableViewController.h"
#import <UIView+SDAutoLayout.h>
@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ContentTableViewControllerDelegate>
typedef NS_ENUM(NSInteger, ShowTableType) {
    ShowTableTypeDefault = 0,//不展示tableView
    ShowTableTypeEsayList = 1,//展示简单的cell的表
    ShowTableTypeGraphic = 2,//展示图文的cell的表
    ShowTableTypeClearHistory = 3//展示清除按钮
};
@property(nonatomic,strong)UILabel *resultCount;
@property(nonatomic,strong)UIButton *clearHistory;
@property(nonatomic,strong)UITableView *resultTable;
@property(nonatomic)ShowTableType tableType;
@property(nonatomic,strong)ContentTableViewController *content;
@end

@implementation SearchViewController
{
    BOOL haveClicked;
    NSMutableArray *historyLists;
    UIView *searchView;
    UITextField *searchText;
    NSArray *results;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    haveClicked = NO;//默认没有点击搜索按钮
    self.automaticallyAdjustsScrollViewInsets = NO;
    historyLists = [[NSMutableArray alloc]initWithCapacity:0];
    self.tableType = 0;
    [self initUI];
}

-(void)initUI
{
    self.title = @"搜索";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"webView_back_normal.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = left;
    
    //搜索框
    [self addSearchBar];
    //搜索结果
    
}

-(void)setTableType:(ShowTableType)tableType
{
    _tableType = tableType;
    switch (tableType) {
        case 0:
            //不展示
        {
            [self removeAllView];
        }
            break;
        case 1:
            //展示简单
        {
            [self removeAllView];

            [self showResultTable];

        }
            break;
        case 2:
            //展示图文
        {
            [self removeAllView];
            [self showResultCount];
            [self showContent];
        }
            break;
        case 3:
            //展示清除按钮
        {
            [self removeAllView];
            [self showResultTable];
            [self showClearHistory];
        }
            break;
        default:
            break;
    }
}

/**清除所有的视图*/
-(void)removeAllView
{
    if (_clearHistory != nil) {
        [_clearHistory removeFromSuperview];
    }
    if (_content != nil) {
        [_content.view removeFromSuperview];
    }
    if (_resultTable != nil) {
        [_resultTable removeFromSuperview];
    }
    if (_resultCount != nil) {
        [_resultCount removeFromSuperview];
    }

}

/**清除历史记录**/
-(void)clearHistory:(UIButton *)button
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"historyLists"];
    [historyLists removeAllObjects];
    self.tableType = 0;
}

-(void)showResultCount
{
    _resultCount = [[UILabel alloc]init];
    [self.view addSubview:_resultCount];
    _resultCount.textColor = [UIColor lightGrayColor];
    _resultCount.textAlignment = UITextAlignmentCenter;
    _resultCount.frame = CGRectMake(0, searchView.frame.origin.y+searchView.frame.size.height, searchView.frame.size.width, 30*HEIGHTMULTIPLE);
    _resultCount.text = [NSString stringWithFormat:@"%lu个结果",(unsigned long)results.count];

}

-(void)showClearHistory
{
    _clearHistory = [[UIButton alloc]init];
    _clearHistory.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _clearHistory.layer.borderWidth = 1.0;
    [_clearHistory setTitle:@"清除历史记录" forState:UIControlStateNormal];
    [_clearHistory setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_clearHistory addTarget:self action:@selector(clearHistory:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat h = 30*HEIGHTMULTIPLE;
    CGFloat y = _resultTable.frame.origin.y+_resultTable.frame.size.height+h*5;
    _clearHistory.center = CGPointMake(self.view.center.x, y);
    _clearHistory.bounds = CGRectMake(0, 0, 130*WIDTHMULTIPLE, h);
    [self.view addSubview:_clearHistory];


}



-(void)showResultTable
{
    _resultTable = [[UITableView alloc]init];
    [self.view addSubview:_resultTable];
    _resultTable.delegate = self;
    _resultTable.dataSource = self;
    [_resultTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _resultTable.sd_layout
    .leftEqualToView(searchView)
    .topSpaceToView(searchView,0)
    .rightEqualToView(searchView)
    .heightIs(44*results.count);
}

-(void)showContent
{
    _content = [[ContentTableViewController alloc]init];
    _content.contents = results;
    _content.delegate = self;
    _content.isSearch = YES;
    CGFloat y =  _resultCount.frame.origin.y+_resultCount.frame.size.height;
    _content.view.frame = CGRectMake(0,y, searchView.frame.size.width, HEIGHT-y);
    [self.view addSubview:_content.view];
}

/**添加搜索框*/
-(void)addSearchBar
{
    searchView = [[UIView alloc]init];
    [self.view addSubview:searchView];
    searchView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8];
    searchView.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(self.navigationController.navigationBar,0)
    .rightSpaceToView(self.view,0)
    .heightIs(50*HEIGHTMULTIPLE);
    
    searchText = [[UITextField alloc]init];
    searchText.borderStyle = UITextBorderStyleRoundedRect;
    searchText.delegate = self;
    searchText.clearButtonMode = UITextFieldViewModeUnlessEditing;
    searchText.placeholder = @"请输入搜索关键字";
    searchText.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search-pressed.png"]];
    searchText.leftView = leftView;
    searchText.returnKeyType = UIReturnKeySearch;
    [searchText addTarget:self action:@selector(getSearchEasyList:) forControlEvents:UIControlEventEditingChanged];
    [searchView addSubview:searchText];
    searchText.sd_layout
    .centerXEqualToView(searchView)
    .centerYEqualToView(searchView)
    .leftSpaceToView(searchView,10)
    .rightSpaceToView(searchView,10)
    .topSpaceToView(searchView,10)
    .bottomSpaceToView(searchView,10);
    
}

/**返回*/
-(void)back
{
    NSLog(@"返回");
    [self.sideMenuViewController presentLeftMenuViewController];
}


/**textField绑定的搜索简单答案*/
-(void)getSearchEasyList:(UITextField *)textF
{
    if (textF.text.length>0) {
        
        [RequestSearch getSearchEasyListWithString:textF.text Success:^(SearchFWResult *result) {
            results = result.data;
            self.tableType = 1;
        }];
    }else{
        NSLog(@"搜索框内为空，要不要展示历史搜索记录，如果点击了搜索就要展示，没有点击就什么都不展示");
        if (haveClicked || historyLists.count>0) {
            NSLog(@"展示历史记录");
            results = historyLists;
            self.tableType = 3;
        }else{
            NSLog(@"什么都不展示");
            self.tableType = 0;
        }
        
    }
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [searchText endEditing:YES];
}

#pragma mark===UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return results.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *data = results[indexPath.row];

        if ([data containsString:@"<br/>"]) {
            NSArray *subData = [data componentsSeparatedByString:@"<br/>"];
            cell = [cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            cell.textLabel.text = subData[0];
            cell.detailTextLabel.text = subData[1];
        }else{
            cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.textLabel.text = data;
        }


    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [searchText endEditing:YES];
    NSString *data = results[indexPath.row];
    if (![historyLists containsObject:data]) {
        [historyLists addObject:data];//保存搜索历史记录
    }
    
    if ([data containsString:@"<br/>"]) {
        NSArray *subData = [data componentsSeparatedByString:@"<br/>"];
        data = subData[0];
    }
    searchText.text = data;
    haveClicked = YES;
    [self requestDataWithString:data];
}

/**请求图文数据*/
-(void)requestDataWithString:(NSString *)str
{
    //点击键盘的按钮查找最终结果
    [RequestSearch getSearchResultWithString:str Success:^(SearchTWResult *result) {
        results = result.data.list;
        self.tableType = 2;
    }];
}

#pragma mark ==UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    if (textField.text.length>0) {
        if (![historyLists containsObject:textField.text]) {
            [historyLists addObject:textField.text];//保存搜索历史记录
        }        haveClicked = YES;
        //点击键盘的按钮查找最终结果
        [self requestDataWithString:textField.text];
    }
    
    return YES;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
    for (NSString *da in historyLists) {
        NSLog(@"WillAppear=====%@",da);
    }
    [use setObject:historyLists forKey:@"historyLists"];
    [use synchronize];//立即存储
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
   NSArray *array = [use objectForKey:@"historyLists"];
    
    historyLists = [[NSMutableArray alloc]initWithArray:array];
    if (historyLists.count>0) {
        //需要展示简单cell的tableview
        results = historyLists;
        self.tableType = 3;
    }else{
        self.tableType = 0;
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark==ContentTableViewControllerDelegate
-(void)contentGetContentDetail:(ContentENSObject *)contentDetail
{
    NSLog(@"------%@",contentDetail.data.contents.title);
    ContentdetailViewController *detail = [[ContentdetailViewController alloc]init];
    detail.isSearch = YES;
    detail.contentDetail = contentDetail;
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:detail] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
