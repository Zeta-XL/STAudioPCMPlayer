//
//  ViewController.m
//  PCMPlayerDemo
//
//  Created by 赵鑫磊 on 16/3/30.
//  Copyright © 2016年 赵鑫磊. All rights reserved.
//

#import "ViewController.h"
#import "STAudioPCMPlayer.h"

#define kReadByteLength 960*2*2
@interface ViewController () <STAudioPCMPlayerDataSource> {
    Byte _readInBuffer[kReadByteLength];
}

@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;

@property (nonatomic, strong) STAudioPCMPlayer *player;

@property (assign, nonatomic) BOOL canRest;
@property (assign, nonatomic) BOOL isDataReady;

@property (assign, nonatomic) FILE *pcmFile;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)onLoadDataButtonPress:(UIButton *)sender {
    [self initPCMData];
}


- (void)initPCMData {
    if (self.isDataReady) {
        return;
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"music_ios.pcm" ofType:nil];
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (!exist) {
        return;
    }
    self.pcmFile = fopen(filePath.UTF8String, "r");
    
    self.player = [[STAudioPCMPlayer alloc] init];
    
    self.player.dataSource = self;
    
    [self.player prepareToPlay];
    self.isDataReady = YES;
    self.canRest =YES;
    

}

- (IBAction)onPlayerPauseButtonPress:(UIButton *)sender {
    if (!_isDataReady) {
        return;
    }
    sender.selected = !sender.selected;
    if (sender.isSelected) {
        [self.player play];
    } else {
        [self.player pause];
    }
    
}

- (IBAction)onResetButtonPress:(UIButton *)sender {
    if (!self.canRest) {
        return;
    }
    
    [self.player stop];
    self.playPauseButton.selected = NO;
    fclose(self.pcmFile);
    self.pcmFile = NULL;
    
    self.canRest = NO;
    self.isDataReady = NO;
}



#pragma mark --- Audio Player DataSource
- (Byte *)audioPCMPlayer:(STAudioPCMPlayer *)player hasBytesWithLength:(UInt32 *)byteLength {
    
    if (feof(self.pcmFile)) {
        
        fseek(self.pcmFile, 0, SEEK_SET);
    }
    
    fread(_readInBuffer, sizeof(Byte), kReadByteLength, self.pcmFile);
    
    *byteLength = kReadByteLength;
    
    
    return (Byte *)_readInBuffer;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
