//
//  STAudioPCMPlayer.h
//  Local4CHAudioPlayer
//
//  Created by 赵鑫磊 on 16/3/28.
//  Copyright © 2016年 赵鑫磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#define kQueueBufferCount (6)
#define kMinSizePerBuffer (1024*2*2)
#define kFillBufferSize (960*2*2)

FOUNDATION_EXPORT NSString * const STAudioPCMPlayerStateDidChangeNotification;

typedef NS_ENUM(NSInteger, STAudioPCMPlayerState){
    STAudioPCMPlayerStateIdle = 0,
    STAudioPCMPlayerStatePrepare,
    STAudioPCMPlayerStatePlaying,
    STAudioPCMPlayerStatePause,
    STAudioPCMPlayerStateError
};

@class STAudioPCMPlayer;
@protocol STAudioPCMPlayerDataSource <NSObject>
@optional
- (Byte *)audioPCMPlayer:(STAudioPCMPlayer *)player hasBytesWithLength:(UInt32 *)byteLength;

- (void)audioPCMPlayer:(STAudioPCMPlayer *)player shouldFillInBuffer:(Byte *)inBuffer withBufferLength:(UInt32)bufferLength;

@end


@interface STAudioPCMPlayer : NSObject

@property (nonatomic, assign) double sampleRate;
@property (nonatomic, assign) AudioStreamBasicDescription audioDescription; //音频输出参数

@property (nonatomic, weak) id <STAudioPCMPlayerDataSource> dataSource;
@property (nonatomic, assign, readonly) STAudioPCMPlayerState currentState;
@property (nonatomic, copy) void(^configAudioSession)(AVAudioSession *audioSession);


- (instancetype)initWithSampleRate:(NSInteger)sampleRate numerOfChannel:(NSInteger)numOfChannel;

- (instancetype)initWithSampleRate:(NSInteger)sampleRate;

/*
 * play 之前先调用prepareToPlay
 */
- (void)prepareToPlay;

- (void)play;

- (void)pause;

- (void)stop;

@end
