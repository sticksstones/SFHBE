//
//  AbilityMindControl.m
//  S&D2
//
//  Created by VINIT AGARWAL on 1/5/12.
//  Copyright (c) 2012 sticks+stones games. All rights reserved.
//

#import "AbilityMindControl.h"
#import "Ship.h"

@implementation AbilityMindControl

- (void)performAbility {
  Ship* ship = (Ship*)sourceToken;
  [ship addPassiveAbility:self step:@"onUpdate"];
}

- (void)update {
  Ship* ship = (Ship*)sourceToken;
  ship.playerNum = -ship.playerNum;
  if(ship.direction != 0) {
    [ship deploy];
  }
  [ship removePassiveAbility:self step:@"onUpdate"];
}


@end
