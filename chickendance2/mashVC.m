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
@synthesize aView,player,loadingView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = BARBUTTON(@"More", @selector(viewGallery));
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
    
    
    if (app.myMashUrl == (id)[NSNull null]) {
        
        [NSTimer scheduledTimerWithTimeInterval:0.5 
                                         target:self 
                                       selector:@selector(getMashLoop)
                                       userInfo:nil repeats:NO];
        
    } else {
        self.loadingView.hidden = YES;
        [self playMovie];
        
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)viewGallery{
    galleryVC *gvc = [[galleryVC alloc] initWithNibName:@"galleryVC" bundle:nil];
    [[self navigationController] pushViewController:gvc animated:YES];
    [gvc release];    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc{
    [loadingView release];
    [aView release];
    [super dealloc];
}

@end
