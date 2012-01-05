//
//  AbilityDestruct.m
//  S&D2
//
//  Created by VINIT AGARWAL on 1/5/12.
//  Copyright (c) 2012 sticks+stones games. All rights reserved.
//

#import "AbilityDestruct.h"
#import "Ship.h"

@implementation AbilityDestruct

- (void)performAbility {
  Ship* ship = (Ship*)sourceToken;
  [ship addPassiveAbility:self step:@"onUpdate"];
}

- (void)update {
  Ship* ship = (Ship*)sourceToken;
  [ship killShip];
  [ship removePassiveAbility:self step:@"onUpdate"];
}


@end
