//
//  mashVC.m
//  chickendance2
//
//  Created by Anna Billstrom on 7/21/12.
//  Copyright (c) 2012 banane.com. All rights reserved.
//

#import "mashVC.h"
#import "galleryVC.h"
#import "chickendance2AppDelegate.h"

#define BARBUTTON(TITLE, SELECTOR) [[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR] autorelease]

@interface mashVC ()

@end

@implementation mashVC
@synthesize aView,player,loadingView,loadMovieUrl,shareButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationItem.rightBarButtonItem = BARBUTTON(@"More", @selector(viewGallery));

    [self getMashLoop];

}


-(void)playMovie{
    chickendance2AppDelegate *app = (chickendance2AppDelegate *)[[UIApplication sharedApplication] delegate];

    NSLog(@" in play movie, log: %@",app.myMashUrl);
	self.player = [[MPMoviePlayerController alloc] initWithContentURL:app.myMashUrl];	 
	player.view.frame = aView.bounds;
	self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	[self.aView addSubview:player.view];
	[self.player play]; 
}

-(void)getMashLoop{
    chickendance2AppDelegate *app = (chickendance2AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *mashurlStr =[app.myMashUrl absoluteString];
    
    if ([mashurlStr length]==0){
        
        [NSTimer scheduledTimerWithTimeInterval:0.5 
                                         target:self 
                                       selector:@selector(getMashLoop)
                                       userInfo:nil repeats:NO];
        
    } else {
        self.loadingView.hidden = YES;
        self.shareButton.hidden = NO;
        [self playMovie];
        
    }
    
}

-(IBAction)shareFacebook:(id)sender{
    chickendance2AppDelegate *app = (chickendance2AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![app.facebook isSessionValid]) {
        NSArray* permissions = [[[NSArray alloc] initWithObjects:
                                @"publish_stream", nil] autorelease];
        [app.facebook authorize:permissions];
    }
    [app feedPublish];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)viewGallery:(id)sender{
    galleryVC *gvc = [[galleryVC alloc] initWithNibName:@"galleryVC" bundle:nil];
    [[self navigationController] pushViewController:gvc animated:YES];
    [gvc release];    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)dealloc{
    [shareButton release];
    [loadMovieUrl release];
    [loadingView release];
    [aView release];
    [player release];
    [super dealloc];
}

@end
