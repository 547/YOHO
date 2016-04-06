//
//  HeaderCollectionReusableView.m
//  YOHo
//
//  Created by mac on 16/4/3.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "HeaderCollectionReusableView.h"
#import "Data.h"
#import <UIView+SDAutoLayout.h>
@implementation HeaderCollectionReusableView
-(id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, WIDTH, 20);
        [self initUI];
    }
    return self;
}

/**初试UI**/
-(void)initUI
{
    CGFloat margin = 15;
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    _type = [[UILabel alloc]init];
    _type.backgroundColor = [UIColor blackColor];
    _type.textColor = [UIColor whiteColor];
    _type.font = [UIFont systemFontOfSize:13];
    _type.numberOfLines = 1;
    _type.textAlignment = UITextAlignmentCenter;
    _type.frame = CGRectMake(15, 0, w*0.23, h);
    
//    _type.sd_layout.leftSpaceToView(self,15)
//    .topSpaceToView(self,0)
//    .heightRatioToView(self,1);
    [_type setSingleLineAutoResizeWithMaxWidth:w];
    
    [self addSubview:_type];
    
    _more = [[UIButton alloc]init];
    _more.frame = CGRectMake(w-margin-w*0.22, 0, w*0.22, h);
    
//    _more.sd_layout
//    .topSpaceToView(self,0)
//    .rightSpaceToView(self,10)
//    .heightRatioToView(self,1)
//    .widthRatioToView(self,0.4);
    
    
    [self addSubview:_more];
    [_more setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_more setTitle:@"More>" forState:UIControlStateNormal];
}
@end
