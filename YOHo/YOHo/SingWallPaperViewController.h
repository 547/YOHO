//
//  SingWallPaperViewController.h
//  YOHo
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 Seven. All rights reserved.
//

/**查看单张壁纸的页面*/
#import <UIKit/UIKit.h>
#import "Data.h"
#import "DataModels.h"
#import <UIImageView+WebCache.h>
#import <UIView+SDAutoLayout.h>
@interface SingWallPaperViewController : UIViewController
@property(nonatomic,strong)WallPapersImages *image;
@end
