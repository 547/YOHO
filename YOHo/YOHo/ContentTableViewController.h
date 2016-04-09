//
//  ContentTableViewController.h
//  YOHo
//
//  Created by mac on 16/3/31.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <SDCycleScrollView.h>
#import "Data.h"
#import "MainTableViewCell.h"
#import <UITableView+SDAutoTableViewCellHeight.h>
#import "RequestContentDetail.h"
#import "DataModels.h"
@protocol ContentTableViewControllerDelegate;
@interface ContentTableViewController : UITableViewController
@property(nonatomic,strong)NSArray *contents;
@property(nonatomic,strong)NSMutableArray *items;
@property(nonatomic,strong)NSArray *banners;
@property(nonatomic,unsafe_unretained)BOOL isSearch;
@property(nonatomic,unsafe_unretained)id<ContentTableViewControllerDelegate>delegate;
@end
@protocol ContentTableViewControllerDelegate <NSObject>

-(void)contentGetContentDetail:(ContentENSObject *)contentDetail;
-(void)contentGetSearchResultDetail:(SearchTWList *)searchResultDetail;
@end