//
//  AppDelegate.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/3/11.
//  Copyright sticks+stones games 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
