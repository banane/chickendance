//
//  galleryVC.m
//  chickendance2
//
//  Created by Anna Billstrom on 7/21/12.
//  Copyright (c) 2012 Momentus Media. All rights reserved.
//

#import "galleryVC.h"
#import "chickendance2AppDelegate.h"
#import "viewMovie.h"

@interface galleryVC ()

@end

@implementation galleryVC
@synthesize scrollView, movies;

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
    self.title = @"Chicken Mashes";
    NSLog(@"in load view");
    AmazonS3Client *s3 = [[[AmazonS3Client alloc] initWithAccessKey:ACCESS_KEY_ID withSecretKey:SECRET_KEY] autorelease];
    
    @try {
        
        S3ListObjectsRequest *req = [[S3ListObjectsRequest alloc] initWithName:BUCKET_T];
        
        S3ListObjectsResponse *resp = [s3 listObjects:req];
        
        NSMutableArray* objectSummaries = resp.listObjectsResult.objectSummaries;  
        CGRect fullScreenRect=[[UIScreen mainScreen] applicationFrame];
        int width = fullScreenRect.size.width;
        int dimension = width/4;
        int counter=0;

        int row = 0;
        int col = 0;
        
        for(id movieThumb in objectSummaries){
            NSLog(@"movie: %@",movieThumb);
            NSString *thumbfile = [NSString stringWithFormat:@"https://s3.amazonaws.com/chickenthumbs/%@",movieThumb];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:thumbfile]]];

            UIButton *btn = [[UIButton alloc] initWithFrame: CGRectMake(col*dimension,row*dimension,dimension,dimension)];
            
            [btn setBackgroundImage:image forState:UIControlStateNormal];
            
            [btn addTarget:self 
                       action:@selector(viewMovie:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = counter;
            
            [self.scrollView addSubview:btn];
            [btn release];
            if(col==3){
                col=0;
                row+=1;
            } else {
                col+=1;
            }
            counter +=1;
        }
        float height = (row * dimension);
        self.scrollView.contentSize = CGSizeMake(width,height);
        self.movies = objectSummaries;
    }
    @catch (NSException *exception) {
        NSLog(@"Cannot list S3 %@",exception);
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
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
-(IBAction)viewMovie:(id)sender{
    NSString *thumbname = [NSString stringWithFormat:@"%@",[self.movies objectAtIndex:[sender tag]]];
    if([thumbname length]>0){
        NSArray *thumbnameArray = [thumbname componentsSeparatedByString:@"."];
        NSString *thumbMovieString = [NSString stringWithFormat:@"http://s3.amazonaws.com/chickenmash/%@.mov",[thumbnameArray objectAtIndex:0]];
        NSURL *thumbMovieUrl = [NSURL URLWithString:thumbMovieString];
        
        
        viewMovie *vmc = [[viewMovie alloc] initWithNibName:@"viewMovie" bundle:nil];
        vmc.movieUrl = thumbMovieUrl; 
        [[self navigationController] pushViewController:vmc animated:YES];
        [vmc release];
    }
    
}
-(IBAction)viewHome:(id)sender{
     [[self navigationController] popToRootViewControllerAnimated:YES];
 }

-(void)dealloc{
    [movies release];
    [scrollView release];
    [super dealloc];
}

@end
