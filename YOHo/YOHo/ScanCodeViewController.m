//
//  ScanCodeViewController.m
//  YOHo
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ScanCodeViewController.h"
#import <RESideMenu.h>
#import "TypeViewController.h"
@interface ScanCodeViewController ()

@end

@implementation ScanCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}


/**初始化UI**/
-(void)initUI
{
    self.title = @"二维码扫描";
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"shared_back_whiteEMG@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(toThePhotoAlbum)];
    self.sideMenuViewController.navigationItem.leftBarButtonItem = left;
    self.sideMenuViewController.navigationItem.rightBarButtonItem = right;
}


/**返回*/
-(void)back
{
    NSLog(@"返回");
    TypeViewController *type = [[TypeViewController alloc]init];
    [self.sideMenuViewController presentLeftMenuViewController:type];
}

/**前往相册**/
-(void)toThePhotoAlbum
{
    NSLog(@"前往相册");

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
