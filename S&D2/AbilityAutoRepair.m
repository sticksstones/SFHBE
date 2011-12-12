//
//  AbilityAutoRepair.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/11/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "AbilityAutoRepair.h"
#import "Ship.h"

@implementation AbilityAutoRepair

- (void)performAbility {
  Ship* ship = (Ship*)sourceToken;
  [ship addPassiveAbility:self step:@"onUpdate"];
  effectInterval = 10.0;
}

- (void)update {
  Ship* ship = (Ship*)sourceToken;
  currentTime += 1.0/60.0;
  if(currentTime >= effectInterval) {
    [ship heal:level];
    currentTime = 0.0;
  }
}


@end
