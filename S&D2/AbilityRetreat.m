//
//  AbilityRetreat.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/10/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "AbilityRetreat.h"
#import "Ship.h"

@implementation AbilityRetreat

- (void)performAbility {
  Ship* ship = (Ship*)sourceToken;
  [ship addPassiveAbility:self step:@"controlBehavior"];
}

- (void)update {
  Ship* ship = (Ship*)sourceToken;
}


@end
