//
//  WallPapersViewController.h
//  YOHo
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 Seven. All rights reserved.
//

/**壁纸*/
#import <UIKit/UIKit.h>
#import "RequestWallPaper.h"
#import "Data.h"
#import "EasyCollectionViewCell.h"
#import "LabelCollectionViewCell.h"
#import <MJRefresh.h>
@protocol WallPapersViewControllerDelegate;
@interface WallPapersViewController : UIViewController
{
    UICollectionView *leftCollection;
    UICollectionView *rightCollection;
}
@property(nonatomic,unsafe_unretained)id<WallPapersViewControllerDelegate>delegate;
@end
@protocol WallPapersViewControllerDelegate <NSObject>

-(void)wallPapersViewControllerGetClickedImage:(WallPapersImages *)image;

@end