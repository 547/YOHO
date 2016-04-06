//
//  MagazineViewController.h
//  YOHo
//
//  Created by mac on 16/4/3.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestMagazine.h"
#import "DataModels.h"
#import "CustomerCollectionViewCell.h"
#import "Data.h"
#import "HeaderCollectionReusableView.h"
@protocol MagazineViewControllerDelegate;
@interface MagazineViewController : UIViewController
@property(nonatomic,unsafe_unretained)int type;
@property(nonatomic,unsafe_unretained)id<MagazineViewControllerDelegate>delegate;
@end

@protocol MagazineViewControllerDelegate <NSObject>

-(void)magazineViewCGoToReadingMagazineWithSavePath:(NSString *)savePath;
-(void)magazineViewCGoToSeeMoew:(NSMutableArray *)datas;
@end


