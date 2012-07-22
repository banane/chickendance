//
//  galleryVC.h
//  chickendance2
//
//  Created by Anna Billstrom on 7/21/12.
//  Copyright (c) 2012 Momentus Media. All rights reserved.
//
#define ACCESS_KEY_ID          @"AKIAJSGCJUUN4LGVN3RQ"
#define SECRET_KEY             @"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"
#define BUCKET_T @"chickenthumbs"

#import <UIKit/UIKit.h>
#import <AWSiOSSDK/S3/AmazonS3Client.h>
#import <MediaPlayer/MediaPlayer.h>

@interface galleryVC : UIViewController <UIScrollViewDelegate> {
    IBOutlet UIScrollView *scrollView;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

-(IBAction)viewMovie:(id)sender;

@end
