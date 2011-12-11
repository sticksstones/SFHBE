//
//  AbilityManager.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/10/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Ability;

@interface AbilityManager : NSObject {
  NSMutableDictionary* abilities;
}

+ (AbilityManager*)instance;
- (void)initManager;
- (id)getAbility:(NSString*)ability;

@end
