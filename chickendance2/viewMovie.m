//
//  viewMovie.m
//  chickendance2
//
//  Created by Anna Billstrom on 7/21/12.
//  Copyright (c) 2012 Momentus Media. All rights reserved.
//

#import "viewMovie.h"

@interface viewMovie ()

@end

@implementation viewMovie
@synthesize player, movieUrl, aView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)playMovie{
    if(!(self.movieUrl  == (id)[NSNull null])){
        [self.player prepareToPlay];

        NSLog(@"in play movie: %@",self.movieUrl);
        self.player = [[MPMoviePlayerController alloc] initWithContentURL:self.movieUrl];	 
        self.player.view.frame = aView.bounds;
        self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.aView addSubview:player.view];
        [self.player play]; 
    } else {
        NSLog(@"no movie url");
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Chicken Mash";
    [self playMovie];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc{
    [player release];
    [aView release];
    [super dealloc];
}

@end
