//
//  AppDelegate.m
//  SignMeStory
//
//  Created by YenHsiang Wang on 2/22/13.
//  Copyright (c) 2013 YenHsiang Wang. All rights reserved.
//

#import "AppDelegate.h"
#import "SignMeStoryFS.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*
    SignMeStoryFS *storyFS = [[SignMeStoryFS alloc] initFS];
    // Override point for customization after application launch.
    NSMutableString *bundlePath = [NSMutableString stringWithCapacity:4];
    [bundlePath appendString:[[NSBundle mainBundle] bundlePath]];
    NSMutableString *fsPath = bundlePath;
    NSMutableString *path1 = [NSMutableString stringWithFormat:@"%@/Inventory/Greenbeanies/",fsPath];
     NSMutableString *path2 = [NSMutableString stringWithFormat:@"%@/Inventory/Greenbeanies2/",fsPath];
    if ([storyFS checkForPath:path1]) {
        NSLog(@"Path need to delete");
        [storyFS deleteFileDirectory:path1];
    }
    if ([storyFS checkForPath:path2]) {
        NSLog(@"Path need to delete");
        [storyFS deleteFileDirectory:path2];
    }
     */
    [PGView initWithParentalGateAppKey:@"FE289EDE6D90F69C02FAED09293"];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
