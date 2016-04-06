//
//  WallPapersViewController.m
//  YOHo
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "WallPapersViewController.h"

@interface WallPapersViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,EasyCollectionViewCellDelegate>
@property(nonatomic,strong)NSArray *rightDatas;
@property(nonatomic,strong)NSMutableArray *leftDatas;
@end

@implementation WallPapersViewController


-(id)init
{
    self = [super init];
    if (self) {
        _leftDatas = [[NSMutableArray alloc]init];
        [self getData];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    
}

/**初始化UI*/
-(void)initUI
{
    
    CGFloat margin = 10;
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    UICollectionViewFlowLayout *leftFlow = [[UICollectionViewFlowLayout alloc]init];
    
    
    leftCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,w*1/3,h) collectionViewLayout:leftFlow];
    leftCollection.backgroundColor = [UIColor whiteColor];
    [leftCollection registerClass:[LabelCollectionViewCell class] forCellWithReuseIdentifier:@"label"];
    leftCollection.tag = 100;
    leftCollection.showsVerticalScrollIndicator = NO;
    leftCollection.delegate = self;
    leftCollection.dataSource = self;
    [self.view addSubview:leftCollection];
    
    UICollectionViewFlowLayout *rightFlow = [[UICollectionViewFlowLayout alloc]init];
    
    CGFloat rw = w-leftCollection.frame.size.width;
    CGFloat iw = (rw-2.5*margin)*0.5;
    rightFlow.itemSize = CGSizeMake(rw-margin, iw*1.5*2+margin*2);
    
    rightCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(leftCollection.frame.size.width, leftCollection.frame.origin.y, rw-margin, leftCollection.frame.size.height) collectionViewLayout:rightFlow];
    rightCollection.backgroundColor = [UIColor whiteColor];
    [rightCollection registerClass:[EasyCollectionViewCell class] forCellWithReuseIdentifier:@"easy"];
    rightCollection.tag = 101;
    rightCollection.delegate = self;
    rightCollection.dataSource = self;
    [self.view addSubview:rightCollection];
    
    leftFlow.itemSize = CGSizeMake(leftCollection.frame.size.width,rightFlow.itemSize.height);
}

-(void)getData
{
    
    [RequestWallPaper getWallPapersSummerySuccess:^(NSArray *wallPapers) {
        _rightDatas = wallPapers;
        NSString *mon = nil;
        NSString *jour = nil;
        for (WallPapersWallpaperList *wall in wallPapers) {
            mon = wall.month;
            jour = wall.journal;
            NSDictionary *a = [NSDictionary dictionaryWithObjectsAndKeys:jour,mon, nil];
            [_leftDatas addObject:a];
        }
        
        [rightCollection reloadData];
        [leftCollection reloadData];
        
    }];
    
}





#pragma mark===scrollView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    leftCollection.contentOffset = scrollView.contentOffset;
    rightCollection.contentOffset = scrollView.contentOffset;
}


#pragma mark===UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _rightDatas.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 100) {
        LabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"label" forIndexPath:indexPath];
        //解决重用的问题===移除所有的子视图
        if (cell != nil) {
            for (UIView *view in cell.subviews) {
                [view removeFromSuperview];
            }
        }
        cell = [cell init];
        cell.datas = _leftDatas[indexPath.row];
        return cell;
    }else{
        EasyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"easy" forIndexPath:indexPath];
        if (cell != nil) {
            for (UIView *view in cell.subviews) {
                [view removeFromSuperview];
            }
        }
        cell = [cell init];
        cell.delegate = self;
        WallPapersWallpaperList *list = _rightDatas[indexPath.row];
        cell.list = list;
        return cell;
    }
    
}


#pragma mark==EasyCollectionViewCellDelegate
/**获取被点击的wallPaperImage*/
-(void)easyCollectionViewCellClickedImage:(WallPapersImages *)image
{
    [self.delegate wallPapersViewControllerGetClickedImage:image];
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
