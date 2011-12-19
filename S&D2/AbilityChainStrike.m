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
//    CGPoint boardPos = [attackTarget getBoardXY];
//    for(int x = 1; x <= level; ++x) {
//      Tile* tile = [[[BoardManager instance] getBoard] getTileX:boardPos.x+playerNum*x Y:boardPos.y];
//      if(tile) {
//        NSArray* occupants = [tile getOccupants];
//        for (Ship* token in occupants) {
//          [token damage:[ship getAp]];
//        }
//      }
//    }
  }
}

@end
