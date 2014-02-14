//
//  AppDelegate.m
//  Quickcall
//
//  Created by 大野 篤史 on 2014/02/02.
//  Copyright (c) 2014年 Atsushi Ohno. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "SubViewController.h"
#import <MessageUI/MessageUI.h>

@implementation AppDelegate

@synthesize window;
@synthesize name1, name2, name3, name4;
@synthesize title1, title2, title3;
@synthesize body1, body2, body3;
@synthesize address1, address2, address3;
@synthesize number;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    window.backgroundColor = [UIColor whiteColor];
    
    
    UITabBarController *rootController = [[UITabBarController alloc]init];
    MainViewController *mainViewController = [[MainViewController alloc]initWithNibName:nil bundle:nil];
    SubViewController *subViewcontroller = [[SubViewController alloc]initWithNibName:nil bundle:nil];
    rootController.viewControllers = [NSArray arrayWithObjects:mainViewController, subViewcontroller, nil];
    
    UIImage *home = [UIImage imageNamed:@"home.png"];
    UIImage *gear = [UIImage imageNamed:@"gear.png"];
    mainViewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"ホーム" image:home tag:0];
    subViewcontroller.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"設定" image:gear tag:1];
    rootController.selectedIndex = 0;
    
    //default setup
    name1 = @"メール1";
    name2 = @"メール2";
    name3 = @"メール3";
    name4 = @"電話";
    
    [window setRootViewController:rootController];
    [window makeKeyAndVisible];
    
    return YES;
}

//電話が終了した時に呼び出される
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    /*
    NSString *notificationContent = [notification.userInfo objectForKey:@"test"];
    NSLog(notificationContent);
     */
    /*
    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if(notification){
        //通知があった時の処理
        NSLog(@"notification!!");
    }
     */
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"I'm background");
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