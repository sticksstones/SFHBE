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

@implementation AbilityHarvest

- (void)performAbility {
  Ship* ship = (Ship*)sourceToken;
  [ship addPassiveAbility:self step:@"onUpdate"];
  effectInterval = 20.0;
  currentTime = 19.9;
}

- (void)update {
  Ship* ship = (Ship*)sourceToken;
  currentTime += 1.0/60.0;
  
  if(currentTime >= effectInterval) {
    if([ship getChildByTag:999] == nil) {
      Mana* mana = [Mana spriteWithFile:@"Mana.png"];
      [mana setManaAmount:25*level];        
      [mana setPlayerNum:[ship playerNum]];
      [mana initialize];
      [ship addChild:mana z:99 tag:999];
    }
    currentTime = 0.0;
  }
}


@end
