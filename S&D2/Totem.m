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
