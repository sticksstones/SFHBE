//
//  AbilityBurn.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/11/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "AbilityBurn.h"
#import "Ship.h"

#define BURN_INTERVAL 2.0
#define BURN_DURATION 4.1

@implementation AbilityBurn 

- (void)performAbility {
  Ship* ship = (Ship*)sourceToken;
  [ship addPassiveAbility:self step:@"onUpdate"];
  effectInterval = BURN_INTERVAL;
  effectDuration = BURN_DURATION;
}

- (void)update {
  Ship* ship = (Ship*)sourceToken;
  currentTime += 1.0/60.0;
  elapsedTime += 1.0/60.0;
  if(currentTime >= effectInterval) {
    [ship damage:level];
    currentTime = 0.0;
  }
  
  if(elapsedTime >= effectDuration) {
    [ship removePassiveAbility:self step:@"onUpdate"];
  }
}



@end
