//
//  chickendance2AppDelegate.m
//  chickendance2
//
//  Created by Anna Billstrom on 7/21/12.
//  Copyright 2012 Momentus Media. All rights reserved.
//

#import "chickendance2AppDelegate.h"

@implementation chickendance2AppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize myMashUrl,facebook;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.
    facebook = [[Facebook alloc] initWithAppId:@"265624126886302" andDelegate:self];
    self.window.rootViewController = self.navigationController;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}
- (void)request:(FBRequest *)request didLoad:(id)result {
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    NSLog(@"Result of API call: %@", result);
}
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Failed with error: %@", [error localizedDescription]);
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [facebook handleOpenURL:url]; 
}
- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}
- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
}
-(void)feedPublish{
/*    NSMutableDictionary *params = 
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"My Chicken Dance!", @"name",
     @"Chicken Dance", @"caption",
     @"Record a song and dance, with Chicken Dance", @"description",
     [self.myMashUrl absoluteString], @"link",    
     @"http://s3.amazonaws.com/chickenthumbs/chick_796430328_1508192489_mash.jpg", @"picture",  
     nil];  
    [self.facebook dialog:@"feed"
                andParams:params
              andDelegate:self];*/
   // NSString *filePath = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"mov"];
    NSData *videoData = [NSData dataWithContentsOfURL:self.myMashUrl];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   videoData, @"video.mov",
                                   @"video/quicktime", @"contentType",
                                   @"Chicken Dance!", @"title",
                                   @"Record your sound and dance separately, we will mash it. Don't worry. It's fun.", @"description",
                                   nil];
    [facebook requestWithGraphPath:@"me/videos"
                         andParams:params
                     andHttpMethod:@"POST"
                       andDelegate:self];
}

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [facebook release];
    [super dealloc];
}

@end
