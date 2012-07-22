//
//  chickendance2AppDelegate.h
//  chickendance2
//
//  Created by Anna Billstrom on 7/21/12.
//  Copyright 2012 Momentus Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface chickendance2AppDelegate : NSObject <UIApplicationDelegate,FBSessionDelegate,FBDialogDelegate>{
    NSURL *myMashUrl;
    Facebook *facebook;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) NSURL *myMashUrl;
@property (nonatomic, retain) Facebook *facebook;


@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
