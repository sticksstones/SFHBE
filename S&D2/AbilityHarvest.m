//
//  AbilityHarvest.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/11/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "AbilityHarvest.h"
#import "Ship.h"
#import "Mana.h"

#define BASE_MANA_AMOUNT 25
#define MANA_SPAWN_INTERVAL 20.0

#define kManaTag 999


@implementation AbilityHarvest

- (void)performAbility {
  Ship* ship = (Ship*)sourceToken;
  [ship addPassiveAbility:self step:@"onUpdate"];
  effectInterval = MANA_SPAWN_INTERVAL;
  currentTime = MANA_SPAWN_INTERVAL - 0.1;
}

- (void)update {
  Ship* ship = (Ship*)sourceToken;
  currentTime += 1.0/60.0;
  
  if(currentTime >= effectInterval) {
    if([ship getChildByTag:kManaTag] == nil) {
      Mana* mana = [Mana spriteWithFile:@"Mana.png"];
      [mana setManaAmount:BASE_MANA_AMOUNT*level];        
      [mana setPlayerNum:[ship playerNum]];
      [mana initialize];
      [ship addChild:mana z:99 tag:kManaTag];
    }
    currentTime = 0.0;
  }
}


@end
