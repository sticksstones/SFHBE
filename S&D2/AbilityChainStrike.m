//
//  AbilityChainStrike.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/10/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "AbilityChainStrike.h"
#import "Ship.h"
#import "BoardManager.h"
#import "Board.h"
#import "Tile.h"

@implementation AbilityChainStrike

- (void)performAbility {
  Ship* ship = (Ship*)sourceToken;
  [ship addPassiveAbility:self step:@"onAttack"];
}

- (void)update {
  Ship* ship = (Ship*)sourceToken;  
  int playerNum = [ship playerNum];
  Ship* attackTarget = [ship attackTarget];
  if(attackTarget) {            
    for(int x = 1; x <= level; ++x) {
      CGPoint pos = CGPointMake(attackTarget.position.x + ship.playerNum*(x)*[[BoardManager instance] getTileSize], attackTarget.position.y);
      CGPoint tileLoc = [[BoardManager instance] getTileLocForPoint:pos];
      NSArray* occupants = [[BoardManager instance] getTokensForSpot:tileLoc];
      for (Ship* token in occupants) {
        if([token playerNum] != playerNum) {
          [token damage:[ship getAp]];
        }
      }
    }
  }
}

@end
