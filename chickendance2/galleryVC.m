//
//  galleryVC.m
//  chickendance2
//
//  Created by Anna Billstrom on 7/21/12.
//  Copyright (c) 2012 Momentus Media. All rights reserved.
//

#import "galleryVC.h"

@interface galleryVC ()

@end

@implementation galleryVC
@synthesize scrollView;

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
    NSLog(@"in load view");
    AmazonS3Client *s3 = [[[AmazonS3Client alloc] initWithAccessKey:ACCESS_KEY_ID withSecretKey:SECRET_KEY] autorelease];
    
    @try {
        
        S3ListObjectsRequest *req = [[S3ListObjectsRequest alloc] initWithName:BUCKET_T];
        
        S3ListObjectsResponse *resp = [s3 listObjects:req];
        
        NSMutableArray* objectSummaries = resp.listObjectsResult.objectSummaries;  
        
        int w = 163;
        int h = 194;
        int row = 0;
        int col = 0;
        
        for(id movieThumb in objectSummaries){
            NSLog(@"movie: %@",movieThumb);
            NSString *thumbfile = [NSString stringWithFormat:@"https://s3.amazonaws.com/chickenthumbs/%@",movieThumb];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:thumbfile]]];

            UIButton *btn = [[UIButton alloc] initWithFrame: CGRectMake(col*w,row*h,w,h)];
            [btn setImage:image forState:UIControlStateNormal];
            
            [btn addTarget:self 
                       action:@selector(viewMovie:) forControlEvents:UIControlEventTouchUpInside];

            
            [self.scrollView addSubview:btn];
            
            if(col==4){
                col=0;
                row+=1;
            } else {
                col+=1;
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Cannot list S3 %@",exception);
    }
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
    // test
}
-(void)dealloc{
    [scrollView release];
    [super dealloc];
}

@end
