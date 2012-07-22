//
//  ViewController.m
//  chickendance
//
//  Created by Anna Billstrom on 7/21/12.
//  Copyright (c) 2012 banane.com. All rights reserved.
//
// Constants used to represent your AWS Credentials.
#define ACCESS_KEY_ID          @"AKIAJSGCJUUN4LGVN3RQ"
#define SECRET_KEY             @"YWc7KzCoig2Qo059pUKbSD+B9zNi7VYvSAwZpycX"
#define TOTALDURATION_V 7
#define BUCKET_V @"chickenvideo"

#import <AWSiOSSDK/S3/AmazonS3Client.h>

#import "videoVC.h"
#import "chickendance2AppDelegate.h"
#import "recordAudioVC.h"
#import "galleryVC.h"
#import "mashVC.h"


@implementation videoVC
@synthesize videoRecorded;

-(void)dance{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.delegate = self;
    imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:     UIImagePickerControllerSourceTypeCamera];
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    imagePicker.videoQuality=UIImagePickerControllerQualityTypeLow;
    imagePicker.videoMaximumDuration = TOTALDURATION_V;
    
    //    imagePicker.showsCameraControls = YES;
    
	[self presentModalViewController:imagePicker animated:YES];
	[imagePicker release];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"the info: %@",info);
    
    NSURL *videoPath = [info objectForKey:UIImagePickerControllerMediaURL];
    [self performSelectorInBackground:@selector(uploadVideo:) withObject:videoPath];
    
    self.videoRecorded = YES;
    
    [self dismissModalViewControllerAnimated:YES];
    
    
}




-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"in rootvc view did appear");
    if(self.videoRecorded){
        [self viewMyMash];
    }
    
}

-(void)viewMyMash{
    mashVC *mvc = [[mashVC alloc] initWithNibName:@"mashVC" bundle:nil];
    [[self navigationController] pushViewController:mvc animated:YES];
    [mvc release];
    
}

-(void)uploadVideo:(NSURL *)videoPath{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    
    NSLog(@"in upload movie");
    AmazonS3Client *s3 = [[[AmazonS3Client alloc] initWithAccessKey:ACCESS_KEY_ID withSecretKey:SECRET_KEY] autorelease];
    
    NSLog(@"video path: %@",videoPath);
    
    int randomnum = arc4random() % 1000000000;
    
    NSString *videoName = [NSString stringWithFormat:@"chick_%d.mov",randomnum];
    
    NSData *videoData = [[NSData alloc] initWithContentsOfURL:videoPath];
    
    if([videoData length] > 0){
        @try {
            S3PutObjectRequest *por = [[[S3PutObjectRequest alloc] initWithKey:videoName inBucket:BUCKET_V] autorelease];
            por.contentType = @"video/quicktime";
            por.data        = videoData;
            por.cannedACL =   [S3CannedACL publicRead];
            
            
            [s3 putObject:por];
            
            NSLog(@"success uploading");
            [self sendServerVideo:videoName];
        }
        @catch (AmazonClientException *exception) {
            NSLog(@"Upload Error: %@",exception.message);
        }
    } else {
        NSLog(@"error: no data in file");
        
    }
    
    [pool release];
    NSLog(@"finished uploading");
    //   return retValue;
}
-(void)sendServerVideo:(NSString *)aVideoName{
    
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    
    NSURL *req_url = [NSURL URLWithString:[NSString stringWithFormat:@"http://ec2-23-22-84-34.compute-1.amazonaws.com/chickendance/makemash.php?videoname=%@",aVideoName]];
    
    NSURLResponse *response;
    NSError *error;
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:req_url 
                                                         cachePolicy:NSURLRequestReloadIgnoringCacheData    
                                                     timeoutInterval:30];
   
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    chickendance2AppDelegate *app = (chickendance2AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *responseDataString = (NSString *)[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"do upload response datastring: %@",responseDataString);
    
    NSDictionary *responseDict = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    app.myMashUrl = [NSURL URLWithString:[responseDict objectForKey:@"mash_path"]];
    
    [pool release];
}

- (void)viewDidLoad
{
    self.videoRecorded = NO;
    [super viewDidLoad];
    [self dance];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (void) didRotate:(NSNotification *)notification

{
    //Maintain the camera in Landscape orientation
    [[UIDevice currentDevice] setOrientation:UIInterfaceOrientationLandscapeLeft];
    
}
 */

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

@end
