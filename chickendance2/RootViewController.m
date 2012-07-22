//
//  ViewController.m
//  chickendance
//
//  Created by Anna Billstrom on 7/21/12.
//  Copyright (c) 2012 banane.com. All rights reserved.
//
// Constants used to represent your AWS Credentials.

#import "RootViewController.h"

//#import "singVC.h"
#import "recordAudioVC.h"
#import "galleryVC.h"
#import "videoVC.h"


@implementation RootViewController


-(IBAction)dance:(id)sender{
    videoVC *vvc = [[videoVC alloc] initWithNibName:@"videoVC" bundle:nil];
    [[self navigationController] pushViewController:vvc animated:YES];
    [vvc release];
}
-(IBAction)sing:(id)sender{
    recordAudioVC *rvc = [[recordAudioVC alloc] initWithNibName:@"recordAudioVC" bundle:nil];
    [[self navigationController] pushViewController:rvc animated:YES];
    [rvc release];
}

-(IBAction)gallery:(id)sender{
    galleryVC *gvc = [[galleryVC alloc] initWithNibName:@"galleryVC" bundle:nil];
    [[self navigationController] pushViewController:gvc animated:YES];
    [gvc release];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (void) didRotate:(NSNotification *)notification

{
    //Maintain the camera in Landscape orientation
    [[UIDevice currentDevice] setOrientation:UIInterfaceOrientationLandscapeLeft];
    
}
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
