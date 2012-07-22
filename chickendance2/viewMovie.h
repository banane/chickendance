//
//  viewMovie.h
//  chickendance2
//
//  Created by Anna Billstrom on 7/21/12.
//  Copyright (c) 2012 Momentus Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface viewMovie : UIViewController{
    NSURL *movieUrl;    
    MPMoviePlayerController *player;
    
    IBOutlet UIView *aView;

}

@property (nonatomic, retain) NSURL *movieUrl;
@property (nonatomic, retain) MPMoviePlayerController *player;
@property (nonatomic, retain) IBOutlet UIView *aView;

-(void)playMovie;

@end
