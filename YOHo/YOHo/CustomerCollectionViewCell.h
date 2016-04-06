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
#import "EasyDownloadTool.h"
#import "Magazines.h"
@protocol CustomerCollectionViewCellDelegate;
@interface CustomerCollectionViewCell : UICollectionViewCell<EasyDownloadToolDelegate>
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
    continueDownloadState=3,
    SucceedState=4
};
typedef NS_ENUM(NSInteger, CellType) {
    cellTypeDefault = 0,
    cellTypeStartedDownload=1
};

@property(nonatomic)DownLoadState downloadState;
@property(nonatomic)CellType cellType;
@property(nonatomic,strong)Magazines *magazineDownload;
@property(nonatomic,strong)UIImageView *contentImage;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIButton *contentButton;

@property(nonatomic,strong)EasyDownloadTool *downTool;
@property(nonatomic,strong)NSProgress *downloadProgress;
@property(nonatomic,copy)NSString *savePath;

@property(nonatomic,strong)MagazineData *magazine;
@property(nonatomic,unsafe_unretained)id<CustomerCollectionViewCellDelegate>delegate;
@end
@protocol CustomerCollectionViewCellDelegate <NSObject>
/**记录下载的对象*/
-(void)customerCollectionViewCellStratDownloadMagazine:(MagazineData *)aMagazine;
/**记录下载完成的对象*/
-(void)customerCollectionViewCellDownloadFinish:(MagazineData *)aMagazine;
/**下载完后再次点击就是阅读*/
-(void)customerCollectionViewCellGotoReadMagazine:(MagazineData *)aMagazine;
/**实时监控下载的进度*/
-(void)customerCollectionViewCellDownloadProgress:(NSProgress *)progress;
@end