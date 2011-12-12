//
//  AbilityMissile.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/10/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "AbilityMissile.h"
#import "ProjectileMissile.h"
#import "GameObjectManager.h"
#import "BoardManager.h"
#import "Ship.h"

@implementation AbilityMissile

- (void)performAbility {
  if([self abilityAvailable]) {
    [self incurCost];    
    if([self checkCriteria:nil]) {
      ProjectileMissile* missile = (ProjectileMissile*)[[ProjectileMissile alloc] newProjectile:[NSArray arrayWithObjects:[NSNumber numberWithInt:level*2],[NSNumber numberWithInt:5+level],[NSNumber numberWithInt:level], @"Missile.png",nil]];
      [missile setPlayerNum:[sourceToken playerNum]];
      [[GameObjectManager instance] addProjectile:missile];
      CGPoint boardPos = [(Ship*)sourceToken getBoardXY];
      [[BoardManager instance] setToken:missile X:(int)boardPos.x+([sourceToken playerNum]) Y:(int)boardPos.y];
      [[BoardManager instance] updateGameTokenBoardPosition:missile];  
      [missile deploy];
    }
    else {
      // fizzle
    }
    [super performAbility];  
  }
}

@end
