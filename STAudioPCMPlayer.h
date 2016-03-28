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

#define kQueueBufferCount (4)
#define kMinSizePerBuffer (1024*2)

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


@end


@interface STAudioPCMPlayer : NSObject

@property (nonatomic, assign) double sampleRate;
@property (nonatomic, assign) AudioStreamBasicDescription audioDescription; //音频输出参数

@property (nonatomic, weak) id <STAudioPCMPlayerDataSource> dataSource;
@property (nonatomic, assign, readonly) STAudioPCMPlayerState currentState;

/*
 * play 之前先调用prepareToPlay
 */
- (void)prepareToPlay;

- (void)play;

- (void)pause;

- (void)stop;

@end
