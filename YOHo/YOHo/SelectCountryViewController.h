//
//  SelectCountryViewController.h
//  YOHo
//
//  Created by mac on 16/3/30.
//  Copyright © 2016年 Seven. All rights reserved.
//
/**选择国家界面**/
#import <UIKit/UIKit.h>
typedef void(^Selected)(NSString *country,int selectRow);

@interface SelectCountryViewController : UIViewController
@property(nonatomic,copy)Selected selectBlock;

-(void)getSelectedInfo:(Selected)select;
@end
