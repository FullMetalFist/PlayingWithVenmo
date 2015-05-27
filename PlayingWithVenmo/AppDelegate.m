//
//  AppDelegate.m
//  PlayingWithVenmo
//
//  Created by Michael Vilabrera on 7/29/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import "AppDelegate.h"

#import <Venmo-iOS-SDK/Venmo.h>
#import "Constants.h"

#import "ViewController.h"

@interface AppDelegate()

@property (nonatomic) ViewController *viewController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Venmo startWithAppId:VENMO_APP_ID secret:VENMO_APP_SECRET name:VENMO_APP_NAME];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[ViewController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = self.viewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}
							
- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([[Venmo sharedInstance] handleOpenURL:url]) {
        
        if (![Venmo isVenmoAppInstalled]) {
            [[Venmo sharedInstance] setDefaultTransactionMethod:VENTransactionMethodAPI];
        }
        else {
            [[Venmo sharedInstance] setDefaultTransactionMethod:VENTransactionMethodAppSwitch];
        }
        return YES;
    }
    return NO;
}
@end
