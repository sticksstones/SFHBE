//
//  AbilityFog.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/10/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "AbilityFog.h"
#import "Ship.h"

#define kFogTag 100

@implementation AbilityFog

- (void)performAbility {
  Ship* ship = (Ship*)sourceToken;
  [ship addPassiveAbility:self step:@"onEncounter"];
  CCSprite* fog = [CCSprite spriteWithFile:@"Fog.png"];
  [ship addChild:fog z:99 tag:kFogTag];
  [fog setPosition:CGPointMake([ship contentSize].width/2,[ship contentSize].height/2)];
}

- (void)update {
  Ship* ship = (Ship*)sourceToken;
  Ship* attackTarget = [ship attackTarget];
  CCSprite* shipFog = (CCSprite*)[ship getChildByTag:kFogTag];
  if(attackTarget) {
    [shipFog setVisible:NO];
  }
  else {
    [shipFog setVisible:YES];
  }
}


@end
