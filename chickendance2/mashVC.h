//
//  mashVC.h
//  chickendance2
//
//  Created by Anna Billstrom on 7/21/12.
//  Copyright (c) 2012 banane.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>



@interface mashVC : UIViewController {
    MPMoviePlayerController *player;
    IBOutlet UIView *aView;
    IBOutlet UIView *loadingView;
    NSURL *loadMovieUrl;
}

@property (nonatomic, retain) IBOutlet UIView *aView;
@property (nonatomic, retain) MPMoviePlayerController *player;
@property (nonatomic, retain) IBOutlet UIView *loadingView;
@property (nonatomic, retain) NSURL *loadMovieUrl;


-(IBAction)viewGallery:(id)sender;
-(void)playMovie;
-(void)getMashLoop;

-(IBAction)shareFacebook:(id)sender;

@end
