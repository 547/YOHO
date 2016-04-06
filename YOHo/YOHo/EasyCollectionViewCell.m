//
//  EasyCollectionViewCell.m
//  YOHo
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "EasyCollectionViewCell.h"
#import "Data.h"
@implementation EasyCollectionViewCell
{
    UIImageView *contentImage;
    NSMutableArray *images;
}
-(id)init
{
    self = [super init];
    if (self) {

        images = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)initUI
{
    
    int count = _list.images.count;
    CGFloat margin = 10*WIDTHMULTIPLE;
    for (int i=0; i<count; i++) {
        
        int h = i%2;
        int v = i/2;
        
        CGFloat w = (self.frame.size.width-margin)/2;
        CGFloat x = (w+margin)*h;
        CGFloat y = (w*1.5+margin)*v;
        UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, w*1.5)];
        im.tag = i;
        
        UIButton *bu = [[UIButton alloc]initWithFrame:im.frame];
        bu.tag = i;
        [bu addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];;
        
        [images addObject:im];
        [self addSubview:im];
        [self addSubview:bu];
    }
}


/**点击button*/
-(void)buttonClicked:(UIButton *)button
{
//实现代理方法
    WallPapersImages *image = _list.images[button.tag];
    
    [self.delegate easyCollectionViewCellClickedImage:image];
}

-(void)setList:(WallPapersWallpaperList *)list
{
    _list = list;
    [self initUI];
    for (int i=0; i<list.images.count; i++) {
        WallPapersImages *image = list.images[i];
        NSString *imageUrl = image.shareUrl;
        NSURL *url = [NSURL URLWithString:imageUrl];
        UIImageView *im = images[i];
        [im sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"magazineUndownloaded.png"]];
    }
    
}



@end
