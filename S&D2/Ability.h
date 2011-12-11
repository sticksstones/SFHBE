//
//  Ability.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/8/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "CCSprite.h"

@interface Ability : CCSprite {
  id sourceToken;
  id targetToken;
  int charges;
  int maxCharges;
  int level;
  float rechargeTime;
  float currentCharge;
  NSString* abilityType;
  NSArray* origParams;
  
}

- (id)copyAbility;
- (void)setSourceToken:(id)token;
- (bool)incurCost;
- (bool)checkCriteria:(NSArray*)params;
- (void)performAbility;
- (void)recharge;
- (void)initialize:(NSArray*)params;
- (bool)abilityAvailable;
- (void)update;

@end
