//
//  CustomerCollectionViewCell.h
//  YOHo
//
//  Created by mac on 16/4/2.
//  Copyright © 2016年 Seven. All rights reserved.
//
/**自定CollectionViewCell*/
#import <UIKit/UIKit.h>
#import <UIView+SDAutoLayout.h>
#import "DataModels.h"
#import "Data.h"
#import <UIImageView+WebCache.h>
#import "CustomerButton.h"
@protocol CustomerCollectionViewCellDelegate;
@interface CustomerCollectionViewCell : UICollectionViewCell
/**下载状态
 0.没下载
 1.正在下载
 2.暂停下载
 3.下载完成
 **/
typedef NS_ENUM(NSInteger, DownLoadState) {
    DefaultState = 0,
    DownloadingState=1,
    PauseState=2,
    SucceedState=3
};
@property(nonatomic)DownLoadState downloadState;
@property(nonatomic,strong)MagazineData *magazine;
@property(nonatomic,unsafe_unretained)id<CustomerCollectionViewCellDelegate>delegate;
@end
@protocol CustomerCollectionViewCellDelegate <NSObject>

-(void)customerCollectionViewCellClicked:(MagazineData *)aMagazine;

@end