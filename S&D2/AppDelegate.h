//
//  AppDelegate.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/3/11.
//  Copyright sticks+stones games 2011. All rights reserved.
//
// Ethan wuz here

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate,UITextFieldDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
  UITextField *deckNameField;
}

@property (nonatomic, retain) UIWindow *window;

- (void)specifyDeckName;

@end
