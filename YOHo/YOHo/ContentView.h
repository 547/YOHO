//
//  ContentView.h
//  YOHo
//
//  Created by mac on 16/3/31.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>
#import "Data.h"
#import "BannerClass.h"
@interface ContentView : UIView<SDCycleScrollViewDelegate>

@property(nonatomic,strong)NSArray *banners;
@property(nonatomic,strong)SDCycleScrollView *cycleView;
@end
