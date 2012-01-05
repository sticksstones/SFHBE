//
//  AbilityHeal.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/10/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "AbilityHeal.h"
#import "ProjectileHeal.h"
#import "GameObjectManager.h"
#import "BoardManager.h"
#import "Ship.h"

@implementation AbilityHeal

- (void)performAbility {
  if([self abilityAvailable]) {
    [self incurCost];    
    if([self checkCriteria:nil]) {
      ProjectileHeal* heal = (ProjectileHeal*)[[ProjectileHeal alloc] newProjectile:[NSArray arrayWithObjects:[NSNumber numberWithInt:level*2],[NSNumber numberWithInt:4+level],[NSNumber numberWithInt:level*2], @"Heal.png",nil]];
      
      Ship* ship = (Ship*)sourceToken;
      int playerNum = [sourceToken playerNum];
      [heal setPlayerNum:playerNum];
      [[GameObjectManager instance] addProjectile:heal];
      
      
      [heal setPosition:CGPointMake(ship.position.x + [ship playerNum]*(ship.contentSize.width/2 + heal.contentSize.width/2), ship.position.y)];

      
      [heal deploy];
    }
    else {
      // fizzle
    }
    [super performAbility];  
  }
}


@end
