//
//  chickendance2AppDelegate.h
//  chickendance2
//
//  Created by Anna Billstrom on 7/21/12.
//  Copyright 2012 Momentus Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface chickendance2AppDelegate : NSObject <UIApplicationDelegate>{
    NSURL *myMashUrl;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) NSURL *myMashUrl;


@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
