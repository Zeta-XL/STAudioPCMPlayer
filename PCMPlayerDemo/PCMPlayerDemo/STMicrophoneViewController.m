//
//  STMicrophoneViewController.m
//  PCMPlayerDemo
//
//  Created by 赵鑫磊 on 2017/8/24.
//  Copyright © 2017年 赵鑫磊. All rights reserved.
//

#import "STMicrophoneViewController.h"
#import "STAudioMicrophone.h"

@interface STMicrophoneViewController () <STAudioMicrophoneDelegate>

@property (strong, nonatomic) STAudioMicrophone *microphone;
@property (assign, nonatomic) FILE *pcmFile;
@end

@implementation STMicrophoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.microphone = [[STAudioMicrophone alloc] initWithSampleRate:44100 numerOfChannel:2];
    self.microphone.delegate = self;
    
}

- (IBAction)onStartPress:(UIButton *)sender {
    NSLog(@"Mic start");
    NSString *docPath= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = @"44100.pcm";
    NSString *filePath = [docPath stringByAppendingPathComponent:fileName];
    self.pcmFile = fopen(filePath.UTF8String, "wb");
    [self.microphone start];
}

- (IBAction)onStopPress:(UIButton *)sender {
    NSLog(@"Mic Stop");
    [self.microphone pause];
    fclose(self.pcmFile);
}


- (void)audioMicrophone:(STAudioMicrophone *)microphone hasAudioPCMByte:(Byte *)pcmByte audioByteSize:(UInt32)byteSize      {
    NSLog(@"内置mic 数据长度: %u", byteSize);
    fwrite(pcmByte, 1, byteSize, self.pcmFile);
    
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
