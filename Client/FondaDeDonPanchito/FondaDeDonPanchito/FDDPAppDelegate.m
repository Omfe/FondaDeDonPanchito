//
//  FDDPAppDelegate.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 4/28/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPAppDelegate.h"
#import "FDDPMainViewController.h"

@implementation FDDPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UINavigationController *navigationController;
    FDDPMainViewController *mainViewController;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    mainViewController = [[FDDPMainViewController alloc] initWithNibName:nil bundle:nil];
    navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
