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
@interface ScanCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation ScanCodeViewController
{
    UIImagePickerController *picker;//相册
    AVCaptureDevice *device;//这里代表抽象的硬件设备
    AVCaptureDeviceInput *input;//这里代表输入设备（可以是它的子类），它配置抽象硬件设备的ports
    AVCaptureMetadataOutput *output;//它代表输出数据，管理着输出到一个movie或者图像
    AVCaptureSession *session;//它是input和output的桥梁。它协调着intput到output的数据传输。
    AVCaptureVideoPreviewLayer *preview;//展示Layer
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
    picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.title = @"相册";
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.sideMenuViewController presentViewController:picker animated:YES completion:nil];
    

}

/**扫描二维码的主要代码*/
-(void)startSacn
{
    
    /**
     output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode]的时候崩溃了，后来发现output.availableMetadataObjectTypes为空，却不知为何为空。google了一遍，大家都说要先设置session的output,可我是已经设置了的，所以排除这种可能性。后来磨叽了很久查了很久google，百度都没结果。到下午的时候突然灵光一闪想着这不是相机么，该不会是关了权限吧，打开设置一看，居然真是把权限关了，然后打开权限，再扫描就ok了，没有再闪退。
     
     后来在扫描之前加了判断相机的访问权限
     **/
//    NSString *mediaType = AVMediaTypeVideo;
    
//    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
//    
//    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusNotDetermined){
//        authStatus = AVAuthorizationStatusAuthorized;
////        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"扫描二维码需要开启相机权限，是否开启？" delegate:self cancelButtonTitle:@"开启" otherButtonTitles:@"取消", nil];
////        
////        [alert show];
////        return;
//    }
    //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    //2.用captureDevice初始化输入流
    input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (!input) {
        NSLog(@"%@",[error localizedDescription]);
        return;
    }
    //3.初始化媒体数据输出流
    output = [[AVCaptureMetadataOutput alloc]init];
     //4.实例化捕捉会话
    session = [[AVCaptureSession alloc]init];
    //4.1.将输入流添加到会话
    [session addInput:input];
    //4.2.将媒体输出流添加到会话中
    [session addOutput:output];
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    //5.创建串行队列，并加媒体输出流添加到队列当中
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    //5.1.设置代理
     [output setMetadataObjectsDelegate:self queue:dispatchQueue];
   //5.2.设置输出媒体数据类型为QRCode==//条形码类型
    [output setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
     //6.实例化预览图层
    preview = [AVCaptureVideoPreviewLayer layerWithSession:session];
    //7.设置预览图层填充方式
    preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
   //8.设置图层的frame
    preview.frame = self.view.layer.bounds;
    //9.将图层添加到预览view的图层上
    [self.view.layer addSublayer:preview];
    
   //10.设置扫描范围=== //设置扫描区域==因为系统默认的是全屏
    [output setRectOfInterest:CGRectMake((124)/HEIGHT,((WIDTH-220)/2)/WIDTH,220/HEIGHT,220/WIDTH)];
    //11.开始扫描
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


#pragma mark===UIImagePickerControllerDelegate
/**实现从相册中选择带有二维码的图片，然后用CIDetector解析图片中带的有二维码，CIDetector还可以用于人脸识别*/
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    CIImage *ciImage = [CIImage imageWithCGImage:[image CGImage]];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
   NSArray *features = [detector featuresInImage:ciImage];
//遍历二维码
    if (features.count>0) {
        NSString *message = @"";
        for (CIQRCodeFeature *fe in features) {
            NSLog(@"%@",fe.messageString);
            NSString *b = [NSString stringWithFormat:@"%@%@",message,fe.messageString];
            message = [NSString stringWithFormat:@"%@\n",b];
        }
        [self showAlterViewWithTitle:@"温馨提示" message:message buttonTitle:@"确定"];
    }else{
        NSLog(@"你选的图片没有二维码");
        [self showAlterViewWithTitle:@"温馨提示" message:@"你选的图片没有二维码" buttonTitle:@"确定"];
    }
}




-(void)showAlterViewWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle
{
//    UIAlertController *alter= [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:nil];
//    [alter addAction:action];
//    [self presentViewController:alter animated:YES completion:nil];
    
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:buttonTitle, nil];
    [alter show];
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
