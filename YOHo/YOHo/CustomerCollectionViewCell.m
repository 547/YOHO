//
//  CustomerCollectionViewCell.m
//  YOHo
//
//  Created by mac on 16/4/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "CustomerCollectionViewCell.h"
#import "Magazines.h"
#import "AppDelegate.h"
#define Content self.contentView
@implementation CustomerCollectionViewCell
{
    AppDelegate *appdelegate;
}
-(id)init
{
    self = [super init];
    if (self) {
        //
        [self initUI];
        
        self.downloadState = 0;
        _downTool = [[EasyDownloadTool alloc]init];
        _downTool.delegate = self;
        appdelegate = [UIApplication sharedApplication].delegate;
        
    }
    return self;
}


/**初始化UI***/
-(void)initUI
{
    _contentImage = [[UIImageView alloc]init];
    _contentImage.frame = CGRectMake(0, 0, Content.frame.size.width, Content.frame.size.height*0.75);
    [Content addSubview:_contentImage];
    
    
    _contentButton = [[UIButton alloc]init];
    _contentButton.frame = _contentImage.frame;
    _contentButton.backgroundColor = [UIColor clearColor];
    [_contentButton addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
    [Content addSubview:_contentButton];
    
    _nameLabel = [[UILabel alloc]init];
    
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.numberOfLines = 1;
    _nameLabel.font = [UIFont systemFontOfSize:10];
    _nameLabel.textAlignment = UITextAlignmentCenter;
    CGFloat y = _contentImage.frame.size.height+5;
    
    _nameLabel.frame= CGRectMake(0, y, _contentImage.frame.size.width, Content.frame.size.width*0.2);
    _nameLabel.text = @"";
    [Content addSubview:_nameLabel];
}

-(void)setMagazine:(MagazineData *)magazine
{

    _magazine = magazine;
    
    [_contentImage sd_setImageWithURL:[NSURL URLWithString:magazine.cover] placeholderImage:[UIImage imageNamed:@"magazineUndownloaded.png"]];
    _nameLabel.text = magazine.journal;
    
    
    BOOL isHave = [self haveMagazineWithName:_magazine.journal];
    if (isHave) {
        //查找
       NSString *st = [self cheakMagazineWithAttribute:@"downloadState"];
        NSString *pro = [self cheakMagazineWithAttribute:@"progress"];
        self.downloadState = [st intValue];
    }
    
}

-(void)setMagazineDownload:(Magazines *)magazineDownload
{
    _magazineDownload = magazineDownload;
    
    [_contentImage sd_setImageWithURL:[NSURL URLWithString:magazineDownload.imageUrl] placeholderImage:[UIImage imageNamed:@"magazineUndownloaded.png"]];
    _nameLabel.text = magazineDownload.name;
    self.downloadState = [magazineDownload.downloadState intValue];

    NSLog(@"下载状态：====%d",_downloadState);
}

-(void)setDownloadState:(DownLoadState)downloadState
{
    _downloadState = downloadState;
    NSString *state = [NSString stringWithFormat:@"%d",downloadState];
    switch (downloadState) {
        case 0:
            //没下载
            [self setContentButtonTitle:@""];
            break;
        case 1:
            //正在下载==显示进度
        {
            
            _contentButton.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.2];
//            NSLog(@"=1====%@",_nameLabel.text);
//            NSLog(@"-----%@",[NSThread isMainThread]?@"主线程":@"不是");
            _nameLabel.text = @"下载中...";
            NSLog(@"=2====%@",_nameLabel.text);
            [self.downTool startDownLoadWithUrlString:self.magazine.address fileName:self.magazine.journal];
            [self saveMagazine];
//            [self.delegate customerCollectionViewCellStratDownloadMagazine:_magazine];
        }
            break;
        case 2:
            //暂停下载==不显示进度
        {
            self.contentButton.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.2];
            [self setContentButtonTitle:@""];
            _nameLabel.text = @"暂停";
            [self updateMagazinedataWithAttribute:@"downloadState" value:state];
            [self.downTool pauseDownload];
        }
            break;
        case 3:
            //继续下载
        {
            _contentButton.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.2];
            _nameLabel.text = @"下载中...";
            [self updateMagazinedataWithAttribute:@"downloadState" value:state];
            [self.downTool continueDownLoad];
        }
            break;
        case 4:
            //下载完成
        {
            NSLog(@"下载完成");
            _contentButton.backgroundColor = [UIColor clearColor];
            [self setContentButtonTitle:@""];
            _nameLabel.text = self.magazine.journal;
            
            [self updateMagazinedataWithAttribute:@"downloadState" value:state];
//            [self.delegate customerCollectionViewCellDownloadFinish:_magazine];
        }
            break;
            
        default:
            break;
    }
    
    
    
}


-(void)setContentButtonTitle:(NSString *)title
{

    [_contentButton setTitle:title forState:UIControlStateNormal];
    [_contentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}





-(void)selectItem:(UIButton *)button
{
   
    switch (self.downloadState) {
        case 0:
            //没下载
            self.downloadState = 1;
            break;
        case 1:
            //正在下载
            self.downloadState = 2;
            break;
        case 2:
            //暂停下载
            self.downloadState = 3;
            break;
        case 3:
            //继续下载
            self.downloadState = 2;
            
            break;
        case 4:
            //下载完成
        {
            self.downloadState = 4;
            NSString *path = [self cheakMagazineWithAttribute:@"savePath"];
            _magazine.savePath = path;
            //查看杂志
            [self.delegate customerCollectionViewCellGotoReadMagazine:_magazine];
        }
           
            break;

        default:
            break;
    }
    

}

-(void)setDownloadProgress:(NSProgress *)downloadProgress
{
    _downloadProgress = downloadProgress;
    NSString *pro = [NSString stringWithFormat:@"%0.2f%%",_downloadProgress.fractionCompleted*100];
    
//    [self.delegate customerCollectionViewCellDownloadProgress:downloadProgress];
    [self performSelectorOnMainThread:@selector(setContentButtonTitle:) withObject:pro waitUntilDone:YES];
    
    sleep(1);
    /**修改下载进度*/
    [self updateMagazinedataWithAttribute:@"progress" value:pro];
}

#pragma mark===获取minieMagazines
/**获取minieMagazines*/
-(BOOL)haveMagazineWithName:(NSString *)name
{
    NSFetchRequest *fet = [NSFetchRequest fetchRequestWithEntityName:@"Magazines"];
    fet.predicate = [NSPredicate predicateWithFormat:@"name=%@",name];
    NSArray *results = [appdelegate.managedObjectContext executeFetchRequest:fet error:nil];
    if (results.count>0) {
        return YES;
    }else{
        return NO;
    }
}

/**查看属性**/
-(id)cheakMagazineWithAttribute:(NSString *)attribute
{
    NSFetchRequest *fet = [NSFetchRequest fetchRequestWithEntityName:@"Magazines"];
    fet.predicate = [NSPredicate predicateWithFormat:@"name=%@",_magazine.journal];
    NSArray *results = [appdelegate.managedObjectContext executeFetchRequest:fet error:nil];
    Magazines *m = results[0];
    
    return [m valueForKey:attribute];
}

#pragma mark===保存对象到CocoData中

/**保存杂志对象*/
-(void)saveMagazine
{
    
    //保存之前看看之前是否已经保存过

   BOOL isHave = [self haveMagazineWithName:_magazine.journal];
    if (isHave) {
        NSLog(@"已经存在！");
        return;
        
    }else{
        NSLog(@"新数据要保存！");
        Magazines *maga = [NSEntityDescription insertNewObjectForEntityForName:@"Magazines" inManagedObjectContext:appdelegate.managedObjectContext];
        maga.name = _magazine.journal;
        maga.imageUrl = _magazine.cover;
        NSString *state = [NSString stringWithFormat:@"%d",_downloadState];
        maga.downloadState = state;
        NSString *proge = [NSString stringWithFormat:@"%0.2f%%",_downloadProgress.fractionCompleted];
        maga.progress = proge;
        maga.savePath = _magazine.savePath;
        maga.resumeData = _magazine.resumeData;
        [appdelegate saveContext];
    }
    
    
}

/**修改数据*/
-(void)updateMagazinedataWithAttribute:(NSString *)attribute value:(id)value
{

    NSFetchRequest *fet = [NSFetchRequest fetchRequestWithEntityName:@"Magazines"];
    
    fet.predicate = [NSPredicate predicateWithFormat:@"name = %@",_magazine.journal];
    NSArray *result = [appdelegate.managedObjectContext executeFetchRequest:fet error:nil];
    for (Magazines *m in result) {
        [m setValue:value forKey:attribute];
    }
    [appdelegate saveContext];
}

-(void)setSavePath:(NSString *)savePath
{
    _savePath = savePath;
    
    
    [self updateMagazinedataWithAttribute:@"savePath" value:savePath];
}


#pragma mark ==downToolDelegate

-(void)easyDownloadSavePath:(NSString *)path
{
    _magazine.savePath = path;
    self.savePath = path;
}

-(void)easyDownloadProgress:(NSProgress *)progress
{

    self.downloadProgress = progress;
    if (progress.fractionCompleted == 1) {
    self.downloadState = 4;
    }
}

-(void)easyDownloadResumeData:(NSData *)reData
{
    _magazine.resumeData = reData;
    [self updateMagazinedataWithAttribute:@"resumeData" value:reData];
}

@end
