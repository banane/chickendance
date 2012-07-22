//
//  videoVC.h
//  chickendance2
//
//  Created by Anna Billstrom on 7/22/12.
//  Copyright (c) 2012 Momentus Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface videoVC : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    BOOL videoRecorded;
}
@property BOOL videoRecorded;

-(void)sendServerVideo:(NSString *)aVideoName;
-(void)uploadVideo:(NSURL *)videoPath;
-(void)viewAudioRecord;
-(void)viewMyMash;
-(void)dance;


@end
