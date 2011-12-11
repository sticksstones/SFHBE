//
//  AbilityHelper.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/10/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "AbilityHelper.h"
#import "Ability.h"
#import "AbilityBlink.h"
#import "AbilityMissile.h"
#import "AbilityHeal.h"
#import "AbilityFog.h"
#import "AbilityChainStrike.h"

@implementation AbilityHelper

+ (id)AbilityForType:(NSString*)type {

  if([type isEqualToString:@"Blink"]) {
    return [[AbilityBlink alloc] init];    
  }
  else if([type isEqualToString:@"Missile"]) {
    return [[AbilityMissile alloc] init];
  }
  else if([type isEqualToString:@"Heal"]) {
    return [[AbilityHeal alloc] init];
  }
  else if([type isEqualToString:@"Fog"]) {
    return [[AbilityFog alloc] init];    
  }
  else if([type isEqualToString:@"ChainStrike"]) {
    return [[AbilityChainStrike alloc] init];
  }
  
  return nil;
}

@end
