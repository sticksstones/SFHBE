//
//  ProjectileHeal.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/10/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "ProjectileHeal.h"
#import "GameObjectManager.h"

#define ATTACK_DISTANCE 1

@implementation ProjectileHeal

- (void)setPlayerNum:(int)num {
  playerNum = num;
  self.rotation = num == 1 ? 90 : 270;
  self.color = ccc3(0, 255, 0);
}

- (bool)checkAttackAvailable {
  GameToken* closestToken = [[GameObjectManager instance] getClosestGameTokenTo:self enemyOnly:false];
  
  if (closestToken != nil) {
    if([self positionRelativeToToken:closestToken] <= ATTACK_DISTANCE) {
      attackTarget = (Ship*)closestToken;
      return YES;
    }
    else {
      return NO;
    }
  }
  return NO;
}


- (void)onContact {
  [attackTarget heal:ap];
  [self killShip];
}


@end
