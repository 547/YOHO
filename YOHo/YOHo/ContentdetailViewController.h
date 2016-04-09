//
//  ContentdetailViewController.h
//  YOHo
//
//  Created by mac on 16/4/7.
//  Copyright © 2016年 Seven. All rights reserved.
//

/**专题详情界面*/
#import <UIKit/UIKit.h>
#import "Data.h"
#import <RESideMenu.h>
#import "MainViewController.h"
#import "DataModels.h"
@interface ContentdetailViewController : UIViewController
@property(nonatomic,strong)ContentENSObject *contentDetail;
@property(nonatomic,strong)RecommendSum *recommendSum;
@property(nonatomic,copy)NSString *selectChannel;
@end
