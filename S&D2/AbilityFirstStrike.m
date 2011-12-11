//
//  AbilityFirstStrike.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/10/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "AbilityFirstStrike.h"

#import "Ship.h"

@implementation AbilityFirstStrike

- (void)performAbility {
  Ship* ship = (Ship*)sourceToken;
  [ship addPassiveAbility:self step:@"onEncounter"];
}

- (void)update {
  Ship* ship = (Ship*)sourceToken;
  Ship* attackTarget = [ship attackTarget];
  if(attackTarget) {
    [ship resetShot];
  }
}


@end
