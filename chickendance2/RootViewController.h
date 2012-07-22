//
//  RootViewController.h
//  chickendance2
//
//  Created by Anna Billstrom on 7/21/12.
//  Copyright 2012 banane.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    BOOL videoRecorded;
}

@property BOOL videoRecorded;

-(IBAction)dance:(id)sender;

-(IBAction)gallery:(id)sender;

-(void)uploadVideo:(NSURL *)videoPath;

-(IBAction)singView:(id)sender;

-(void)sendServerVideo:(NSString *)aVideoName;

-(void)viewAudioRecord;

@end
