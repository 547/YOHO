//
//  EasyCollectionViewCell.h
//  YOHo
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModels.h"
#import <UIImageView+WebCache.h>
@protocol EasyCollectionViewCellDelegate;
@interface EasyCollectionViewCell : UICollectionViewCell
@property(nonatomic,unsafe_unretained)id<EasyCollectionViewCellDelegate>delegate;
@property(nonatomic,strong)UIButton *contentButton;

@property(nonatomic,strong)WallPapersWallpaperList *list;
@end
@protocol EasyCollectionViewCellDelegate <NSObject>

-(void)easyCollectionViewCellClickedImage:(WallPapersImages *)image;

@end