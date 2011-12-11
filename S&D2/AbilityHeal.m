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

@implementation AbilityHeal

- (void)performAbility {
  if([self abilityAvailable]) {
    [self incurCost];    
    if([self checkCriteria:nil]) {
      ProjectileHeal* heal = (ProjectileHeal*)[[ProjectileHeal alloc] newProjectile:[NSArray arrayWithObjects:[NSNumber numberWithInt:level*2],[NSNumber numberWithInt:2+level],[NSNumber numberWithInt:level*2], @"Heal.png",nil]];
      int playerNum = [sourceToken playerNum];
      [heal setPlayerNum:playerNum];
      [[GameObjectManager instance] addProjectile:heal];
      CGPoint boardPos = [(Ship*)sourceToken getBoardXY];
      [[BoardManager instance] setToken:heal X:(int)boardPos.x+1*([sourceToken playerNum]) Y:(int)boardPos.y];
      [[BoardManager instance] updateGameTokenBoardPosition:heal];  
      [heal deploy];
    }
    else {
      // fizzle
    }
    [super performAbility];  
  }
}


@end
