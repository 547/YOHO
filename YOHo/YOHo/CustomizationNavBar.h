//
//  CustomizationNavBar.h
//  YOHo
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 Seven. All rights reserved.
//
/**自定义导航条*/
#import <UIKit/UIKit.h>

@interface CustomizationNavBar : UIView
@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,unsafe_unretained)BOOL enableContentViewTap;
@end
