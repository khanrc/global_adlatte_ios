//
//  ADAppDelegate.h
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 4..
//  Copyright (c) 2013년 Tae Han Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

- (void) setupBasicTabs;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
