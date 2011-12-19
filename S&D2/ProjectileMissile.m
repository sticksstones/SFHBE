//
//  ProjectileMissile.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/10/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "ProjectileMissile.h"
#import "GameToken.h"
#import "GameObjectManager.h"

#define ATTACK_DISTANCE 0.0


@implementation ProjectileMissile

- (void)onContact {
  [attackTarget damage:ap];
  [self killShip];
}

- (bool)checkAttackAvailable {
  GameToken* closestToken = [[GameObjectManager instance] getClosestGameTokenTo:self enemyOnly:true];
  
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


@end
