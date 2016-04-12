//
//  ReadingMagazineViewController.h
//  YOHo
//
//  Created by mac on 16/4/11.
//  Copyright © 2016年 Seven. All rights reserved.
//

/**阅读杂志*/
#import <UIKit/UIKit.h>
#import "DataModels.h"
#import <SSZipArchive.h>
#import "Data.h"
#import <UIView+SDAutoLayout.h>
@interface ReadingMagazineViewController : UIViewController
@property(nonatomic,strong)MagazineData *magazine;
@property(nonatomic,copy)NSString *savePath;
@end
