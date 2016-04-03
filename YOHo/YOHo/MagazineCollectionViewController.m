//
//  MagazineCollectionViewController.m
//  YOHo
//
//  Created by mac on 16/4/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "MagazineCollectionViewController.h"

@interface MagazineCollectionViewController ()

@end

@implementation MagazineCollectionViewController
{
    NSMutableArray *yohoDatas;
    NSMutableArray *specialDatas;
}
static NSString * const reuseIdentifier = @"Cell";

-(id)init
{
    self = [super init];
    if (self) {
        yohoDatas = [[NSMutableArray alloc]init];
        specialDatas = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

-(void)setType:(int)type
{

    _type = type;
    if (type != 2) {
        [self getMagazineDataWithType:_type+1];
    }else if (type == 2){
    
        //查找已经下载、正在下载的数据
        NSLog(@"查找已经下载、正在下载的数据");
        
    }
    
    
}

#pragma mark== 请求杂志数据
/**请求杂志数据**/
-(void)getMagazineDataWithType:(int)type
{
    NSString *typeStr = [NSString stringWithFormat:@"%d",type];
    [RequestMagazine getMagazinesSummeryWithWithType:typeStr Success:^(NSArray *magazines) {
        
        for (MagazineData *magazine in magazines) {
            NSString *journal = magazine.journal;
            if ([journal containsString:@"!"]) {
                [yohoDatas addObject:magazine];
            }else{
                [specialDatas addObject:magazine];
            }
        }
        
        [self.collectionView reloadData];
    }];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
