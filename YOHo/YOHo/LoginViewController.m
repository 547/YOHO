//
//  LoginViewController.m
//  YOHo
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 Seven. All rights reserved.
//

/**登录界面*/
#import "LoginViewController.h"
#import "Data.h"
#import <UIView+SDAutoLayout.h>
#import "SelectCountryViewController.h"
#import <RESideMenu.h>
@interface LoginViewController ()

@end

@implementation LoginViewController
{
    UITextField *countext;
    UIScrollView *scroll;
    SelectCountryViewController *select;
    UILabel *selectedCoun;
    UILabel *moLa;
    NSArray *numbers;
    UIImageView *yohoImage;
    UIButton *familyButoon;
    UITextField *userText;
    UITextField *pawText;
    UIButton *loginButton;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNotificationCenter *center  = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(changeView) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(restoreView) name:UIKeyboardWillHideNotification object:nil];
    numbers = @[@"61",@"82",@"1",@"60",@"1",@"81",@"65",@"44",@"86",@"853",@"886",@"852"];
    [self initUI];
}

/**初始化UI*/
-(void)initUI
{
    self.view.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.6];

    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-20-35, 19, 35, 35)];
    
    [button setBackgroundImage:[UIImage imageNamed:@"cancelImage"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    barView.backgroundColor = [UIColor clearColor];
    [barView addSubview:button];
    [self.view addSubview:barView];
    
    scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
    scroll.userInteractionEnabled = YES;
    scroll.pagingEnabled = YES;
    scroll.contentSize = CGSizeMake(WIDTH*2, HEIGHT-64);
    scroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scroll];

    [scroll addSubview:[self setLoginView]];
    
    [scroll addSubview:[self setRegisterView]];
    
    
}

/**登录界面*/
-(UIView *)setLoginView
{
    UIView *loginView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    yohoImage = [[UIImageView alloc]init];
    yohoImage.center = CGPointMake(WIDTH*0.5, 50);
    yohoImage.bounds = CGRectMake(0, 0, 160*WIDTHMULTIPLE, 100*HEIGHTMULTIPLE);
    yohoImage.image = [UIImage imageNamed:@"yoHo"];
    [loginView addSubview:yohoImage];
    
    familyButoon = [[UIButton alloc]init];
    familyButoon.center = CGPointMake(yohoImage.center.x, yohoImage.frame.size.height+20);
    familyButoon.bounds = CGRectMake(0, 0, yohoImage.frame.size.width+20, 20);
    familyButoon.font = [UIFont systemFontOfSize:12];
    [familyButoon setTitle:@"Yoho!Family账号可登录YOHO!" forState:UIControlStateNormal];
    [familyButoon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [familyButoon addTarget:self action:@selector(showAlterView) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:familyButoon];
    
    userText = [[UITextField alloc]init];
    userText.clearButtonMode = UITextFieldViewModeWhileEditing;
    userText.center = CGPointMake(loginView.center.x, familyButoon.frame.size.height+familyButoon.frame.origin.y+40);
    userText.bounds = CGRectMake(0, 0, WIDTH-20,40);
    userText.placeholder = @"手机号/邮箱";
    userText.borderStyle = UITextBorderStyleRoundedRect;
    [loginView addSubview:userText];
    
    pawText = [[UITextField alloc]init];
    pawText.clearButtonMode = UITextFieldViewModeWhileEditing;
    pawText.center = CGPointMake(loginView.center.x, userText.frame.size.height+userText.frame.origin.y+30);
    pawText.bounds = CGRectMake(0, 0, WIDTH-20,40);
   
    pawText.placeholder = @"密码";
    pawText.borderStyle = UITextBorderStyleRoundedRect;
    [loginView addSubview:pawText];
    
    loginButton = [[UIButton alloc]init];
    loginButton.center = CGPointMake(loginView.center.x, pawText.frame.size.height+pawText.frame.origin.y+30);
    loginButton.bounds = CGRectMake(0, 0, pawText.frame.size.width,pawText.frame.size.height);
    loginButton.layer.cornerRadius = 6;
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.backgroundColor = [UIColor lightGrayColor];
    [loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:loginButton];
    
    
    UIButton *forgetButton = [[UIButton alloc]init];
    forgetButton.frame = CGRectMake(WIDTH-80, loginButton.frame.size.height+loginButton.frame.origin.y, 80, 20);
    [forgetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    forgetButton.font = [UIFont systemFontOfSize:10];
    [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetButton.backgroundColor = [UIColor clearColor];
    [forgetButton addTarget:self action:@selector(forget:) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:forgetButton];
    
    UIView *buttonSet = [[UIView alloc]init];//按钮集合
    buttonSet.center = CGPointMake(loginView.center.x, loginButton.frame.size.height+loginButton.frame.origin.y+50);
    buttonSet.bounds = CGRectMake(0, 0, WIDTH-200, 30*WIDTHMULTIPLE);
//    buttonSet.backgroundColor = [UIColor redColor];
    buttonSet.backgroundColor = [UIColor clearColor];
    [loginView addSubview:buttonSet];
    
    CGFloat VH = buttonSet.frame.size.height;
    for (int i=0; i<3; i++) {
        UIButton *shareButton = [[UIButton alloc]init];
        int j = i%3;
        CGFloat x = (VH+WIDTH*0.5-100-VH*1.5)*j;
        shareButton.frame = CGRectMake(x, 0, VH, VH);
        shareButton.tag = 200+i;
        shareButton.backgroundColor = [UIColor lightGrayColor];
        shareButton.layer.cornerRadius = VH*0.5;
        [shareButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonSet addSubview:shareButton];
        
    }
    
    UIButton *registerButton =[[UIButton alloc]init];
    registerButton.center = CGPointMake(loginView.center.x, buttonSet.frame.size.height+buttonSet.frame.origin.y+30);
    registerButton.bounds = CGRectMake(0, 0, buttonSet.frame.size.width+30, 20);
    [registerButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [registerButton setTitle:@"注册Yoho！Family" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerUser:) forControlEvents:UIControlEventTouchUpInside];
    registerButton.font = [UIFont systemFontOfSize:10];
    [loginView addSubview:registerButton];

    return loginView;
}


/**注册界面*/
-(UIView *)setRegisterView
{
    UIView *regView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT-64)];
//    regView.backgroundColor = [UIColor redColor];
    
    countext = [[UITextField alloc]init];
    countext.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.6];
    countext.center = CGPointMake(self.view.center.x, 20);
    countext.bounds = CGRectMake(0, 0, WIDTH-20, 40);
    countext.layer.cornerRadius = 6;
    countext.enabled = NO;
    
    UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, countext.frame.size.width*0.4, countext.frame.size.height)];
    countLabel.backgroundColor = [UIColor clearColor];
    countLabel.text = @"国家和地区";
    countLabel.textColor = [UIColor whiteColor];
    countLabel.textAlignment = UITextAlignmentCenter;
    countext.leftView = countLabel;
    countext.leftViewMode = UITextFieldViewModeAlways;
    [regView addSubview:countext];
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(countext.frame.size.width*0.5, 0, countext.frame.size.width*0.3, countext.frame.size.height)];
//    rightView.backgroundColor = [UIColor redColor];
    selectedCoun = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, rightView.frame.size.width*0.6, rightView.frame.size.height)];
    selectedCoun.backgroundColor = [UIColor clearColor];
    selectedCoun.text = @"中国";
    selectedCoun.textColor = [UIColor whiteColor];
    selectedCoun.font = [UIFont systemFontOfSize:12];
    selectedCoun.textAlignment = UITextAlignmentRight;
    [rightView addSubview:selectedCoun];
    
    UIImageView *rightImage =[[UIImageView alloc]initWithFrame:CGRectMake(selectedCoun.frame.size.width+5, rightView.frame.size.height*0.25, rightView.frame.size.width*0.25, rightView.frame.size.height*0.5)];
    rightImage.backgroundColor = [UIColor clearColor];
    rightImage.image = [UIImage imageNamed:@"outLineRight"];
    [rightView addSubview:rightImage];
    
    countext.rightView = rightView;
    countext.rightViewMode = UITextFieldViewModeAlways;
    
    UIView *counView = [[UIView alloc]initWithFrame:countext.frame];
    counView.backgroundColor = [UIColor clearColor];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectCountry:)];
    [counView addGestureRecognizer:tap];
    [regView addSubview:counView];
    
    
    UITextField *mobeliText = [[UITextField alloc]init];
    mobeliText.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.6];
    mobeliText.center = CGPointMake(self.view.center.x, countext.frame.size.height+countext.frame.origin.y+30);
    mobeliText.bounds = CGRectMake(0, 0, WIDTH-20,40);
    mobeliText.clearButtonMode = UITextFieldViewModeWhileEditing;
    mobeliText.placeholder = @"手机号";
    mobeliText.borderStyle = UITextBorderStyleRoundedRect;
    moLa = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, mobeliText.frame.size.height, mobeliText.frame.size.height)];
    moLa.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.6];
    moLa.text = @"+86";
    moLa.textAlignment = UITextAlignmentCenter;
    moLa.adjustsFontSizeToFitWidth =YES;
    moLa.textColor = [UIColor whiteColor];
    mobeliText.leftViewMode = UITextFieldViewModeAlways;
    mobeliText.leftView = moLa;
    mobeliText.layer.masksToBounds = YES;
    [regView addSubview:mobeliText];
    
    UIButton *nextStepButton = [[UIButton alloc]init];
    nextStepButton.center = CGPointMake(self.view.center.x, mobeliText.frame.size.height+mobeliText.frame.origin.y+30);
    nextStepButton.bounds = CGRectMake(0, 0, mobeliText.frame.size.width,mobeliText.frame.size.height);
    nextStepButton.layer.cornerRadius = 6;
    
    [nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
    nextStepButton.backgroundColor = [UIColor lightGrayColor];
    [nextStepButton addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    [regView addSubview:nextStepButton];

    UILabel *manessageLabel = [[UILabel alloc]init];
    manessageLabel.center = CGPointMake(self.view.center.x, nextStepButton.frame.origin.y+nextStepButton.frame.size.height+30);
    
    manessageLabel.bounds =CGRectMake(0, 0, WIDTH-100, 40);
    manessageLabel.numberOfLines = 2;
    manessageLabel.textAlignment = UITextAlignmentCenter;
    manessageLabel.font = [UIFont systemFontOfSize:12];
    manessageLabel.textColor  = [UIColor whiteColor];
    manessageLabel.text = @"Yoho！Family账号可登录YohoBuy！有货、YOHO！及SHOW";
    [regView addSubview:manessageLabel];
    
    return regView;
}


/**选择地区*/
-(void)selectCountry:(UITapGestureRecognizer *)tap
{
    NSLog(@"选择地区");
    select = [[SelectCountryViewController alloc]init];
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:self];
    
    na.navigationBarHidden = YES;
    [na pushViewController:select animated:YES];
    
    
    [[UIApplication sharedApplication].delegate window].rootViewController = na;
}

/**下一步**/
-(void)nextStep:(UIButton *)button
{
    NSLog(@"下一步");
}

/**点击注册**/
-(void)registerUser:(UIButton *)button
{
    NSLog(@"点击注册");
    scroll.contentOffset = CGPointMake(WIDTH, 0);
}

/**分享按钮被点击*/
-(void)shareButtonClick:(UIButton *)button
{
    NSLog(@"分享按钮被点击");
}

/**忘记密码*/
-(void)forget:(UIButton *)button
{
    NSLog(@"忘记密码");
}

/**登录*/
-(void)login:(UIButton *)loginB
{
    NSLog(@"登录");
}

/**展示alterView*/
-(void)showAlterView
{
    NSLog(@"展示alterView");
}


/**点击叉号按钮*/
-(void)cancelClick:(UIButton *)button
{
    NSLog(@"点击叉号按钮");
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**键盘将要弹起来**/
-(void)changeView
{
    NSLog(@"键盘将要弹起来");
    CGFloat y = 110;
    yohoImage.frame = CGRectMake(userText.frame.origin.x, yohoImage.frame.origin.y, yohoImage.frame.size.width*0.3, yohoImage.frame.size.height*0.3);
    familyButoon.hidden = YES;
    userText.frame = CGRectMake(userText.frame.origin.x, userText.frame.origin.y-y, userText.frame.size.width, userText.frame.size.height);
    pawText.frame = CGRectMake(pawText.frame.origin.x, pawText.frame.origin.y-y, pawText.frame.size.width, pawText.frame.size.height);
    loginButton.frame = CGRectMake(loginButton.frame.origin.x, loginButton.frame.origin.y-y, loginButton.frame.size.width, loginButton.frame.size.height);
}

/**键盘收起来==视图恢复*/
-(void)restoreView
{
    CGFloat y = 110;
    yohoImage.center = CGPointMake(WIDTH*0.5, 50);
    yohoImage.bounds = CGRectMake(userText.frame.origin.x, yohoImage.frame.origin.y, yohoImage.frame.size.width/0.3, yohoImage.frame.size.height/0.3);
    familyButoon.hidden = NO;
    userText.frame = CGRectMake(userText.frame.origin.x, userText.frame.origin.y+y, userText.frame.size.width, userText.frame.size.height);
    pawText.frame = CGRectMake(pawText.frame.origin.x, pawText.frame.origin.y+y, pawText.frame.size.width, pawText.frame.size.height);
    loginButton.frame = CGRectMake(loginButton.frame.origin.x, loginButton.frame.origin.y+y, loginButton.frame.size.width, loginButton.frame.size.height);
}

-(void)viewWillAppear:(BOOL)animated
{

    
    [select getSelectedInfo:^(NSString *country, int selectRow) {
        if (country != nil) {
            selectedCoun.text = country;
            moLa.text = [NSString stringWithFormat:@"+%@",numbers[selectRow]];
        }

    }];
}





-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [scroll endEditing:YES];
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
