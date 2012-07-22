//
//  recordAudioVC.h
//  chickendance2
//
//  Created by Anna Billstrom on 7/21/12.
//  Copyright 2012 banane.com. All rights reserved.
//
#define ACCESS_KEY_ID          @"AKIAJSGCJUUN4LGVN3RQ"
#define SECRET_KEY             @"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"
#define TOTALDURATION_A 7
#define BUCKET @"chickenaudio"

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface recordAudioVC : UIViewController <AVAudioRecorderDelegate,AVAudioPlayerDelegate> {

    AVAudioRecorder *audioRecorder;
    AVAudioPlayer *audioPlayer;
    
    NSURL *songUrl;
    NSString *songName;
    
    IBOutlet UIButton *singButton;
    IBOutlet UIButton *stopButton;
    IBOutlet UIButton *useButton;
    IBOutlet UIButton *playButton;
    
    IBOutlet UIProgressView *progressView;
    

    
}

@property (nonatomic, retain) AVAudioRecorder *audioRecorder;
@property (nonatomic, retain) AVAudioPlayer *audioPlayer;

@property (nonatomic, retain) NSString *songName;
@property (nonatomic, retain) NSURL *songUrl;

@property (nonatomic, retain) IBOutlet UIButton *singButton;
@property (nonatomic, retain) IBOutlet UIButton *useButton;
@property (nonatomic, retain) IBOutlet UIButton *stopButton;
@property (nonatomic, retain) IBOutlet UIButton *playButton;

 @property (nonatomic, retain)     IBOutlet UIProgressView *progressView;


-(IBAction)sing:(id)sender;
-(IBAction)use:(id)sender;
-(IBAction)stop:(id)sender;

-(void)uploadSong;
-(void)setupRecording;
-(void)moreProgress;
    

-(void)sendServerAudio:(NSString *)aAudioName;
-(IBAction)playRecording:(id)sender;

@end
