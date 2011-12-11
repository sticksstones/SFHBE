//
//  Totem.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/7/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "Totem.h"
#import "PlayerManager.h"
#import "Player.h"

#define PARAMS_HP 0
#define PARAMS_SP 1
#define PARAMS_AP 2
#define PARAMS_SPRITE 3

#define SHOT_DELAY 2.0

#define ATTACK_DISTANCE 2
#define MOVE_DISTANCE 1
#define kHealthTag 1
#define kAPTag 2


@implementation Totem

- (Totem*)newTotem:(NSArray*)params {
  self = (Totem*)[super newShip:params];

  return self;
}

- (void)killShip { 
  Player* owner = [[PlayerManager instance] getPlayer:playerNum];
  owner.health -= 1;
  
  [super killShip];
}


@end
