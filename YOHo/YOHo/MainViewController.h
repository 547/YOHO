//
//  MainViewController.h
//  YOHo
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property(nonatomic,strong)NSArray *scrollArray;
@property(nonatomic,unsafe_unretained)int selectedIndex;
@property(nonatomic,strong)NSString *selectChannel;
@end
