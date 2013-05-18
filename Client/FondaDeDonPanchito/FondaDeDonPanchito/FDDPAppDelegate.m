//
//  FDDPAppDelegate.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 4/28/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPAppDelegate.h"
#import "FDDPLoginViewController.h"

@implementation FDDPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UINavigationController *navigationController;
    FDDPLoginViewController *loginViewController;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    loginViewController = [[FDDPLoginViewController alloc] initWithNibName:@"FDDPLoginViewController" bundle:nil];
    navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
