//
//  galleryVC.h
//  chickendance2
//
//  Created by Anna Billstrom on 7/21/12.
//  Copyright (c) 2012 Momentus Media. All rights reserved.
//
#define ACCESS_KEY_ID          @"xxx"
#define SECRET_KEY             @"xxx"
#define BUCKET_T @"chickenthumbs"

#import <UIKit/UIKit.h>
#import <AWSiOSSDK/S3/AmazonS3Client.h>
#import <MediaPlayer/MediaPlayer.h>

@interface galleryVC : UIViewController <UIScrollViewDelegate> {
    IBOutlet UIScrollView *scrollView;
    NSArray *movies;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) NSArray *movies;

-(IBAction)viewMovie:(id)sender;
-(IBAction)viewHome:(id)sender;

@end
