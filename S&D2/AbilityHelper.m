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
#import "AbilityAutoRepair.h"
#import "AbilityBurn.h"
#import "AbilityHarvest.h"
#import "AbilityDestruct.h"
#import "AbilityMadness.h"
#import "AbilityMindControl.h"
#import "AbilityRecover.h"

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
  else if([type isEqualToString:@"Auto Repair"]) {
    return [[AbilityAutoRepair alloc] init];
  }
  else if([type isEqualToString:@"Burn"]) {
    return [[AbilityBurn alloc] init];
  }
  else if([type isEqualToString:@"Harvest"]) {
    return [[AbilityHarvest alloc] init];
  }
  else if([type isEqualToString:@"Destruct"]) {
    return [[AbilityDestruct alloc] init];
  }
  else if([type isEqualToString:@"Madness"]) {
    return [[AbilityMadness alloc] init];
  }
  else if([type isEqualToString:@"MindControl"]) {
    return [[AbilityMindControl alloc] init];
  }
  else if([type isEqualToString:@"Recover"]) {
    return [[AbilityRecover alloc] init];
  }

  
  return nil;
}

@end
