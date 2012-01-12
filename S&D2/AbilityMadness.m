//
//  AbilityMadness.m
//  S&D2
//
//  Created by VINIT AGARWAL on 1/5/12.
//  Copyright (c) 2012 sticks+stones games. All rights reserved.
//

#import "AbilityMadness.h"
#import "Ship.h"

@implementation AbilityMadness

- (void)performAbility {
  Ship* ship = (Ship*)sourceToken;
  [ship addPassiveAbility:self step:@"onUpdate"];
}

- (void)update {
  Ship* ship = (Ship*)sourceToken;
  [ship deploy];
  [ship pass];
}


@end
