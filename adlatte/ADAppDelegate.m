//
//  ADAppDelegate.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 4..
//  Copyright (c) 2013년 Tae Han Kim. All rights reserved.
//

#import "ADAppDelegate.h"

#import "ADTutorialController.h"
#import "ADListViewController.h"
#import "ADMyViewController.h"
#import "ADStoreViewController.h"
#import "ADSettingViewController.h"

@implementation ADAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Basic Appearance setup
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navi_bar_bg.png"] forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithWhite:0.1 alpha:1.0]];
//    [[UINavigationBar appearance] set :[UIColor yellowColor]];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    if( [self checkLogin] )
    {
        [self setupBasicTabs];
    }
    else
    {
        [self showMeForms];
    }

    // ready for POST working on AFNetworking
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/json",@"application/json",nil]];

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

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

#pragma mark -

- (Boolean) checkLogin
{
    // TODO:
    return NO;
}

- (void) setupBasicTabs
{
    UIViewController *vc1 = [[ADListViewController alloc] initWithStyle:UITableViewStylePlain];
    UIViewController *vc2 = [[ADMyViewController alloc] initWithStyle:UITableViewStylePlain];
    UIViewController *vc3 = [[ADStoreViewController alloc] init];
    UIViewController *vc4 = [[ADSettingViewController alloc] initWithStyle:UITableViewStyleGrouped];

    UINavigationController *N1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    UINavigationController *N2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    UINavigationController *N3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    UINavigationController *N4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[N1, N2, N3, N4];
    self.window.rootViewController = self.tabBarController;

    [[[self tabBarController] tabBar] setBackgroundImage:[UIImage imageNamed:@"tab_bar_bg_320_54.png"]];
    [[[self tabBarController] tabBar] setSelectionIndicatorImage:[UIImage imageNamed:@"tabSelected.png"]];

    [self.window makeKeyAndVisible];
}

- (void) showMeForms
{
    //Tutorial Screen
    ADTutorialController *tutorialVC = [[ADTutorialController alloc] init];
    self.window.rootViewController = tutorialVC;
    [self.window makeKeyAndVisible];
}

@end
