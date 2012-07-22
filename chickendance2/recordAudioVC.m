//
//  recordAudioVC.m
//  chickendance2
//
//  Created by Anna Billstrom on 7/21/12.
//  Copyright 2012 banane.com. All rights reserved.
//

#import "recordAudioVC.h"
#import <AWSiOSSDK/S3/AmazonS3Client.h>
#import "mashVC.h"

@implementation recordAudioVC
@synthesize songName, songUrl, singButton, stopButton, useButton,audioPlayer, audioRecorder,progressView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)sing:(id)sender{
    
    [self setupRecording];
    
    useButton.hidden = YES;
    singButton.hidden = YES;
    stopButton.hidden = NO;
    
    NSError *error = nil;
    
    // button to stop
    
    
    NSLog(@"in clicked");
    if (!audioRecorder.recording)
    {
        if([audioRecorder prepareToRecord]){
            NSLog(@"prepared");
            [audioRecorder recordForDuration:(NSTimeInterval)TOTALDURATION_A];
            
            [self moreProgress];
            [audioRecorder record];
        }else {
            int errorCode = CFSwapInt32HostToBig ([error code]); 
            NSLog(@"Error: %@ [%4.4s])" , [error localizedDescription], (char*)&errorCode); 
        }
    } else {
        NSLog(@"already recording");
    }
    if(audioRecorder.recording){
        NSLog(@"supposedly recording");
    }

}

-(void)moreProgress{
    progressView.progress = audioRecorder.currentTime / TOTALDURATION_A;
    // Have totalDuration as ivar or replace it with '60' same as passed during recorder initialization.
    
    if ( audioRecorder.recording ) {

        [NSTimer scheduledTimerWithTimeInterval:0.5 
                                         target:self 
                                       selector:@selector(moreProgress)
                                       userInfo:nil repeats:NO];
        
    }

}

-(IBAction)stop:(id)sender{
    if (audioRecorder.recording)
    {
        [audioRecorder stop];
    } else if (audioPlayer.playing) {
        [audioPlayer stop];
    }
    useButton.hidden = NO;
    singButton.hidden = NO;
    stopButton.hidden = YES;
    progressView.hidden = YES;
}

-(void)setupRecording{
    
    progressView.hidden = NO;
    progressView.progress = 0.0;

    
    // check for null here
    int randomnum = arc4random() % 1000000000;
    self.songName = [NSString stringWithFormat:@"chicken_%d.wav",randomnum];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"/chickendance/"] 
                              withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString *tmpDirectory = NSTemporaryDirectory();
  
    NSString *soundFilePath = [tmpDirectory
                               stringByAppendingPathComponent:self.songName];
    
    self.songUrl = [NSURL fileURLWithPath:soundFilePath];
    
    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] init];
    [recordSettings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [recordSettings setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey]; 
    [recordSettings setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    [recordSettings setValue :[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [recordSettings setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    [recordSettings setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    

    
    NSError *error;
    
    audioRecorder = [[AVAudioRecorder alloc]
                     initWithURL:self.songUrl
                     settings:recordSettings
                     error:&error];
    
    if (error)
    {
        NSLog(@"song setup error: %@", [error localizedDescription]);
        
    } else {
        
        [audioRecorder prepareToRecord];
    }
    [recordSettings release];
    

}

-(IBAction)use:(id)sender{
    [self performSelectorInBackground:@selector(uploadSong) withObject:nil];
    // go to next view
    mashVC *mvc = [[mashVC alloc] initWithNibName:@"mashVC" bundle:nil];
    [[self navigationController] pushViewController:mvc animated:YES];
    [mvc release];
}

-(void)uploadSong{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    bool retValue;
    
    NSLog(@"in upload song");
    AmazonS3Client *s3 = [[[AmazonS3Client alloc] initWithAccessKey:ACCESS_KEY_ID withSecretKey:SECRET_KEY] autorelease];
     
     NSData *songData = [[NSData alloc] initWithContentsOfURL:self.songUrl];
     
     if([songData length] > 0){
         @try {
             S3PutObjectRequest *por = [[[S3PutObjectRequest alloc] initWithKey:self.songName inBucket:BUCKET] autorelease];
             por.contentType = @"audio/wav";
             por.data        = songData;
             por.cannedACL =   [S3CannedACL publicRead];
             
             
             [s3 putObject:por];
             retValue= YES;
         
         } @catch (AmazonClientException *exception) {
             NSLog(@"Upload Error: %@",exception.message);
             retValue = NO;
         }

     } else {
         NSLog(@"error: no data in file");
         retValue=NO;
     }
    [pool release];

}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    progressView.progress = 0.0;

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
