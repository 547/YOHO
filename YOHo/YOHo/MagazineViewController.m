//
//  MagazineViewController.m
//  YOHo
//
//  Created by mac on 16/4/3.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "MagazineViewController.h"
#import "Magazines.h"
#import "AppDelegate.h"
@interface MagazineViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,CustomerCollectionViewCellDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation MagazineViewController
{
    AppDelegate *appdelegate;
    NSMutableArray *minieMagazines;
    NSMutableArray *yohoDatas;
    NSMutableArray *specialDatas;
    UICollectionView *mycollectionView;
    NSArray *types;
    NSArray *typesNum;
}
static NSString * const reuseIdentifier = @"Cell";

-(id)init
{
    self = [super init];
    if (self) {
//      yohoDatas = [[NSMutableArray alloc]init];
        minieMagazines = [[NSMutableArray alloc]init];
        types = @[@"YOHO!BOY",@"YOHO!GRIL",@"SPECIAL"];
        typesNum = @[@[@"1",@"2"],@[@"3",@"4"]];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

#pragma mark===获取minieMagazines
/**获取minieMagazines*/
-(void)getMagazines
{
    appdelegate = [UIApplication sharedApplication].delegate;
    NSFetchRequest *fet = [NSFetchRequest fetchRequestWithEntityName:@"Magazines"];
    NSArray *results = [appdelegate.managedObjectContext executeFetchRequest:fet error:nil];
    
    minieMagazines = (NSMutableArray *)results;
    for (Magazines *m in minieMagazines) {
        NSLog(@"ma======%@",m.name);
    }
}


#pragma mark==初始化UI
-(void)initUI
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    CGFloat w = WIDTH/4;
    flow.itemSize = CGSizeMake(w, 2*w);
    flow.sectionInset = UIEdgeInsetsMake(20, 15, 0, 15);
    mycollectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flow];
    mycollectionView.backgroundColor = [UIColor whiteColor];
    mycollectionView.delegate = self;
    mycollectionView.dataSource = self;
    
    [mycollectionView registerClass:[CustomerCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [mycollectionView registerClass:[HeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [self.view addSubview:mycollectionView];
}


-(void)setType:(int)type
{
    
    _type = type;
    if (type != 2) {
        [mycollectionView reloadData];
        NSArray *ty = typesNum[_type];
        
        for (int i = 0; i<ty.count; i++) {
            [self getMagazineDataWithType:[ty[i] intValue]];
        }

    }else if (type == 2){
        
        //查找已经下载、正在下载的数据
        NSLog(@"查找已经下载、正在下载的数据");
        [self getMagazines];
        [mycollectionView reloadData];
    }
    
    
}

#pragma mark== 请求杂志数据
/**请求杂志数据**/
-(void)getMagazineDataWithType:(int)type
{
    NSString *typeStr = [NSString stringWithFormat:@"%d",type];
    
    [RequestMagazine getMagazinesSummeryWithWithType:typeStr isAll:NO Success:^(NSArray *magazines) {
        
        NSMutableArray *datasY = [[NSMutableArray alloc]init];
        NSMutableArray *datasS = [[NSMutableArray alloc]init];
        for (MagazineData *magazine in magazines) {
            NSString *journal = magazine.journal;
            NSLog(@"__________________________%@__",journal);
            
            if ([journal containsString:@"!BOY"]||[journal containsString:@"!GIRL"]) {
                [datasY addObject:magazine];
            }else{
                [datasS addObject:magazine];
            }
        }
        if (datasY.count>0) {
            yohoDatas = datasY;
            NSIndexSet *set = [[NSIndexSet alloc]initWithIndex:0];
            [mycollectionView reloadSections:set];
//            [mycollectionView reloadData];
        }
        if (datasS.count>0) {
            specialDatas = datasS;
            NSIndexSet *set = [[NSIndexSet alloc]initWithIndex:1];
            [mycollectionView reloadSections:set];
//            [mycollectionView reloadData];
        }

    }];
    
}


#pragma mark ==UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (_type == 2) {
    return 1;
    }else{
    return 2;
    }
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_type == 2) {
        return minieMagazines.count;
    }else{
    
        if (section == 0) {
            return yohoDatas.count;
            
        }else{
            return specialDatas.count;
            
        }

        
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (cell != nil) {
        for (UIView *view in cell.subviews) {
            [view removeFromSuperview];
        }
    }
    cell = [cell init];
    cell.delegate = self;
    if (_type == 2) {
        cell.magazineDownload = minieMagazines[indexPath.row];
          NSLog(@"-----------%@",cell.nameLabel.text);
    }else{
        if (indexPath.section == 0) {
            cell.magazine = yohoDatas[indexPath.row];
            
        }else{
            cell.magazine = specialDatas[indexPath.row];
          
        }

    }
    
    
    return cell;
}

#pragma mark==为collectionView添加区头

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    CGSize size = CGSizeMake(WIDTH, 20*HEIGHTMULTIPLE);
    return size;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    HeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    header = [header init];
    if (indexPath.section == 0) {
        if (_type !=2) {
            header.type.text = types[_type];
        }
    }else{
        header.type.text = types[2];
    }
    header.more.tag = indexPath.section;
    [header.more addTarget:self action:@selector(seeMore:) forControlEvents:UIControlEventTouchUpInside];
    
    return header;
    
}

/**更多*/
-(void)seeMore:(UIButton *)more
{
    NSLog(@"%d=====%@",more.tag,types[more.tag]);
    NSMutableArray *datas;
    if (more.tag == 0) {
        datas = yohoDatas;
    }
    if (more.tag == 1) {
        datas = specialDatas;
    }
//    [self.delegate magazineViewCGoToSeeMoew:datas];
}

#pragma mark==CustomerCollectionViewCellDelegate
/*下载完成*/
-(void)customerCollectionViewCellDownloadFinish:(MagazineData *)aMagazine
{

}

/**阅读杂志*/
-(void)customerCollectionViewCellGotoReadMagazine:(MagazineData *)aMagazine
{

    NSLog(@"阅读");
    
}

/**记录下载的杂志对象*/
-(void)customerCollectionViewCellStratDownloadMagazine:(MagazineData *)aMagazine
{
//    [minieMagazines addObject:aMagazine];
}

-(void)customerCollectionViewCellDownloadProgress:(NSProgress *)progress
{

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
