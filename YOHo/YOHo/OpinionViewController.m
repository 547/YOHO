//
//  OpinionViewController.m
//  YOHo
//
//  Created by mac on 16/3/31.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "OpinionViewController.h"
#import "MainViewController.h"
#import <RESideMenu.h>
#import "Data.h"
@interface OpinionViewController ()<UITextViewDelegate>

@end

@implementation OpinionViewController
{
    UILabel *label;
    UITextView *opinion;
    UIButton *commitButton;
    CGFloat commitButtonCenterY;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
  NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(upCommitButton:) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(downCommitButton:) name:UIKeyboardDidHideNotification object:nil];
    [self initUI];
}


#pragma mark ==初始化UI
-(void)initUI
{
    self.title = @"意见反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backMian)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    opinion = [[UITextView alloc]init];
    
    //默认是启动键盘 光标位于首位置
//    opinion.text = @"";
//    opinion.selectedRange = NSMakeRange(0, 0);//起始位置
//    opinion.selectedRange = NSMakeRange(@"".length, 0);
    
    opinion.center = CGPointMake(WIDTH*0.5, (HEIGHT-BARHEIGHT-10)*0.8*0.5+BARHEIGHT);
    opinion.bounds = CGRectMake(0, 0, WIDTH-20, (HEIGHT-BARHEIGHT-10)*0.8);
    opinion.delegate = self;
    [self.view addSubview:opinion];
    [self setPlaceHolder];
    
    commitButton = [[UIButton alloc]init];
    commitButton.bounds = CGRectMake(0, 0, WIDTH-40, 40*HEIGHTMULTIPLE);
    commitButtonCenterY = HEIGHT-20-commitButton.frame.size.height*0.5;

    commitButton.layer.cornerRadius = 6;
    commitButton.layer.masksToBounds = YES;
    commitButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    commitButton.layer.borderWidth = 0.5;
    
    commitButton.center = CGPointMake(opinion.center.x, commitButtonCenterY);
    [commitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(commitOpinion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
    
}


#pragma mark===提示文字
/**提示文字**/
-(void)setPlaceHolder
{
    label = [[UILabel alloc]init];

    label.enabled = NO;
    label.frame = CGRectMake(0, -5, opinion.frame.size.width, 80*HEIGHTMULTIPLE);
//    label.center = CGPointMake(opinion.center.x, label.frame.size.height*0.5);
    label.text = @" 欢迎您提出宝贵的意见和建议，您留下的每一个字都将帮助我们不断进步，谢谢！";
    label.numberOfLines = 0;
    label.textColor = [UIColor lightGrayColor];
    [opinion addSubview:label];
}

#pragma mark===提交按钮
/**提交按钮**/
-(void)commitOpinion:(UIButton *)button
{
    NSLog(@"提交按钮");
}

#pragma mark===返回主页
-(void)backMian
{
    MainViewController *main = [[MainViewController alloc]init];
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:main ] animated:YES];
}

#pragma mark===UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    
    if (textView.text.length != 0) {
        label.hidden = YES;
    }else{
        label.hidden = NO;
    }
}

#pragma mark==改变提交按钮的位置
/**上升提交按钮的位置**/
-(void)upCommitButton:(NSNotification *)notifi
{

    commitButton.center = CGPointMake(opinion.center.x, commitButtonCenterY-216);
    
    
}


/**下降按钮*/
-(void)downCommitButton:(NSNotification *)notifi
{
    
    commitButton.center = CGPointMake(opinion.center.x, commitButtonCenterY);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
