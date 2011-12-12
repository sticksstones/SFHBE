//
//  AbilityBurn.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/11/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "Ability.h"

@interface AbilityBurn : Ability {
  float effectInterval;
  float currentTime;
  float elapsedTime;
  float effectDuration;
}

@end
