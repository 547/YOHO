//
//  ScanCodeViewController.m
//  YOHo
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ScanCodeViewController.h"
#import "Data.h"
#import <RESideMenu.h>
#import "TypeViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ScanCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>

@end

@implementation ScanCodeViewController
{
    AVCaptureDevice *device;//这里代表抽象的硬件设备
    AVCaptureDeviceInput *input;//这里代表输入设备（可以是它的子类），它配置抽象硬件设备的ports
    AVCaptureMetadataOutput *output;//它代表输出数据，管理着输出到一个movie或者图像
    AVCaptureSession *session;//它是input和output的桥梁。它协调着intput到output的数据传输。
    AVCaptureVideoPreviewLayer *preview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self startSacn];
}


/**初始化UI**/
-(void)initUI
{
    self.title = @"二维码扫描";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"webView_back_normal.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"images-metadata.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toThePhotoAlbum)];
    self.navigationItem.leftBarButtonItem = left;
    self.navigationItem.rightBarButtonItem = right;
}

/**返回*/
-(void)back
{
    NSLog(@"返回");
    [self.sideMenuViewController presentLeftMenuViewController];
}

/**前往相册**/
-(void)toThePhotoAlbum
{
    NSLog(@"前往相册");

}

/**扫描二维码的主要代码*/
-(void)startSacn
{
    
    /**
     output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode]的时候崩溃了，后来发现output.availableMetadataObjectTypes为空，却不知为何为空。google了一遍，大家都说要先设置session的output,可我是已经设置了的，所以排除这种可能性。后来磨叽了很久查了很久google，百度都没结果。到下午的时候突然灵光一闪想着这不是相机么，该不会是关了权限吧，打开设置一看，居然真是把权限关了，然后打开权限，再扫描就ok了，没有再闪退。
     
     后来在扫描之前加了判断相机的访问权限
     **/
    NSString *mediaType = AVMediaTypeVideo;
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusNotDetermined){
        authStatus = AVAuthorizationStatusAuthorized;
//        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"扫描二维码需要开启相机权限，是否开启？" delegate:self cancelButtonTitle:@"开启" otherButtonTitles:@"取消", nil];
//        
//        [alert show];
//        return;
    }
    
    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    output = [[AVCaptureMetadataOutput alloc]init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置扫描区域==因为系统默认的是全屏
    [output setRectOfInterest:CGRectMake((124)/HEIGHT,((WIDTH-220)/2)/WIDTH,220/HEIGHT,220/WIDTH)];
    
    session = [[AVCaptureSession alloc]init];
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([session canAddInput:input]) {
        [session addInput:input];
    }
    if ([session canAddOutput:output]) {
        [session addOutput:output];
    }
    
    //条形码类型
//    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    output.metadataObjectTypes = [NSArray arrayWithObject:AVMetadataObjectTypeQRCode];
    preview = [AVCaptureVideoPreviewLayer layerWithSession:session];
    preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    preview.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:preview atIndex:0];
    
    //开始
    [session startRunning];
}

#pragma mark ==AVCaptureMetadataOutputObjectsDelegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue = nil;
    if (metadataObjects.count>0) {
        //停止扫描
        [session stopRunning];
        AVMetadataMachineReadableCodeObject *metadata = metadataObjects[0];
        stringValue = metadata.stringValue;
    }
}


#pragma mark===UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

}


-(void)viewDidDisappear:(BOOL)animated
{
    [session stopRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
