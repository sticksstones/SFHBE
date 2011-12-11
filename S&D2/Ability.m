//
//  Ability.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/8/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "Ability.h"
#import "AbilityHelper.h"

#define PARAMS_SRCTOKEN 0
#define PARAMS_DSTTOKEN 1
#define PARAMS_CHARGES 2
#define PARAMS_RECHARGE 3
#define PARAMS_LEVEL 4
#define PARAMS_TYPE 5

@implementation Ability

- (void)initialize:(NSArray*)params {
  sourceToken = [params objectAtIndex:PARAMS_SRCTOKEN];
  targetToken = [params objectAtIndex:PARAMS_DSTTOKEN];  
  maxCharges = [[params objectAtIndex:PARAMS_CHARGES] intValue];
  charges = maxCharges;
  rechargeTime = [[params objectAtIndex:PARAMS_RECHARGE] floatValue];
  currentCharge = 0.0;
  level = [[params objectAtIndex:PARAMS_LEVEL] intValue];
  origParams = [[NSArray alloc] initWithArray:params];
  abilityType = [[NSString alloc] initWithString:[params objectAtIndex:PARAMS_TYPE]];
}

- (id)copyAbility {
  id copy = [AbilityHelper AbilityForType:abilityType];
  [copy initialize:origParams];
  return copy;
}

- (void)setSourceToken:(id)token {
  sourceToken = token;
}

- (bool)abilityAvailable {
  return ((charges > 0 || maxCharges < 0) && (currentCharge <= 0.0 || rechargeTime < 0.0));
}

- (void)recharge {
  if (currentCharge > 0.0) {
    currentCharge -= 0.1;
    [self performSelector:@selector(recharge) withObject:self afterDelay:0.1];    
  }
  else {
    currentCharge = 0.0;
  }
}

- (bool)incurCost {
  return YES;
}

- (bool)checkCriteria:(NSArray*)params {
  return YES;
}

- (void)performAbility {
  charges--;
  currentCharge = rechargeTime;
  [self performSelector:@selector(recharge) withObject:self afterDelay:0.1];      
}

- (void)update {
  
}

@end
