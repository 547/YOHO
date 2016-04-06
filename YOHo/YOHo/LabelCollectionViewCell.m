//
//  LabelCollectionViewCell.m
//  YOHo
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "LabelCollectionViewCell.h"
#import <UIView+SDAutoLayout.h>
#import "Data.h"
@implementation LabelCollectionViewCell
{
    UILabel *starL;
    UILabel *jourL;
    UILabel *monL;
    UILabel *lineL;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

/**初始化UI*/
-(void)initUI
{
    
    CGFloat w = self.frame.size.width;
    CGFloat margin = 30*WIDTHMULTIPLE;
    starL = [[UILabel alloc]init];
    
    starL.frame = CGRectMake(0, 0, w-margin*0.5, 10*HEIGHTMULTIPLE);
    [self addSubview:starL];
    
    jourL = [[UILabel alloc]init];
    jourL.frame = CGRectMake(0, starL.frame.size.height, w-margin, starL.frame.size.height*3);
    [self addSubview:jourL];
    
    monL = [[UILabel alloc]init];
    monL.frame = CGRectMake(0, jourL.frame.size.height+jourL.frame.origin.y, jourL.frame.size.width, starL.frame.size.height*2);
    [self addSubview:monL];
    
    lineL = [[UILabel alloc]init];
    lineL.frame = CGRectMake(0, monL.frame.size.height+monL.frame.origin.y+10*HEIGHTMULTIPLE, monL.frame.size.width, 1.0);
    [self addSubview:lineL];
    
    starL.textColor = [UIColor blackColor];
    starL.font = [UIFont systemFontOfSize:23];
    starL.textAlignment = UITextAlignmentRight;
    starL.numberOfLines = 1;
    starL.text = @"﹡";
    
    jourL.textColor = [UIColor blackColor];
    jourL.font = [UIFont systemFontOfSize:23];
    jourL.textAlignment = UITextAlignmentRight;
    jourL.numberOfLines = 1;
    
    monL.textColor = [UIColor blackColor];
    monL.font = [UIFont systemFontOfSize:20];
    monL.textAlignment = UITextAlignmentRight;
    monL.numberOfLines = 1;

    lineL.backgroundColor = [UIColor lightGrayColor];
    
}

-(void)setDatas:(NSDictionary *)datas
{

    NSString *jou = datas.allValues[0];
    jourL.text = jou;
    monL.text = datas.allKeys[0];
    if ([jou intValue]<100) {
        starL.textColor = [UIColor magentaColor];
        jourL.textColor = [UIColor magentaColor];
        monL.textColor = [UIColor magentaColor];
        lineL.backgroundColor = [UIColor magentaColor];
    }

}



@end
