//
//  ViewController.m
//  录制视频
//
//  Created by 苗建浩 on 2017/7/13.
//  Copyright © 2017年 苗建浩. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

#define screenWidth  [UIScreen mainScreen].bounds.size.width
#define screenHight  [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *imagePickerCon;
@property (nonatomic, strong) AVPlayerViewController *player;
@property (nonatomic, strong) NSURL *mediaUrl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"录制视频";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    recordBtn.frame = CGRectMake((screenWidth - 100) / 2, 100, 100, 40);
    recordBtn.backgroundColor = [UIColor lightGrayColor];
    [recordBtn setTitle:@"拍摄视频" forState:0];
    [recordBtn setTitleColor:[UIColor darkGrayColor] forState:0];
    [recordBtn addTarget:self action:@selector(recordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recordBtn];
    
    
    UIButton *palyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    palyBtn.frame = CGRectMake((screenWidth - 100) / 2, 160, 100, 40);
    palyBtn.backgroundColor = [UIColor lightGrayColor];
    [palyBtn setTitle:@"播放视频" forState:0];
    [palyBtn setTitleColor:[UIColor darkGrayColor] forState:0];
    [palyBtn addTarget:self action:@selector(palyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:palyBtn];
    
    
    UIImagePickerController *imagePickerCon = [[UIImagePickerController alloc] init];
    //  采集员类型
    imagePickerCon.sourceType = UIImagePickerControllerSourceTypeCamera;
    //  媒体类型
    imagePickerCon.mediaTypes = [NSArray arrayWithObject:(__bridge NSString *)kUTTypeMovie];
    //  视频质量
    imagePickerCon.videoQuality = UIImagePickerControllerQualityTypeHigh;
    //  设置代理
    imagePickerCon.delegate = self;
    self.imagePickerCon = imagePickerCon;
    
}


- (void)recordBtnClick:(UIButton *)sender{
    NSLog(@"拍摄视频");
    //  如果摄像头可用，从摄像头采集视频
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self presentViewController:self.imagePickerCon animated:YES completion:nil];
    }
}

//   采集媒体数据完成的回掉处理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //  获取媒体类型
    NSString *type = info[UIImagePickerControllerMediaType];
    
    //  如果是视频类型
    if ([type isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
        //  获取视频的URL
        _mediaUrl = info[UIImagePickerControllerMediaURL];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//   采集媒体数据取消的回掉处理
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"取消了视频");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)palyBtnClick:(UIButton *)sender{
    NSLog(@"播放视频");
    if (_mediaUrl == nil) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"没有视频" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        AVPlayerViewController *player = [[AVPlayerViewController alloc] init];
        player.player = [[AVPlayer alloc] initWithURL:_mediaUrl];
        //  全屏播放的时候
        [self presentViewController:player animated:YES completion:nil];
        //  小屏播放
        //        player.view.frame = CGRectMake(10, 100, 300, 400);
        //        [self.view addSubview:player.view];
        
        [player.player play];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
