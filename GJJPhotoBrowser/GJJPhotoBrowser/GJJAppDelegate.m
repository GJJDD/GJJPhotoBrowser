//
//  GJJAppDelegate.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJAppDelegate.h"
#import "GJJRootViewController.h"
@interface GJJAppDelegate ()

@end

@implementation GJJAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:[[UINavigationController alloc] initWithRootViewController:[[GJJRootViewController alloc] init]]];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
