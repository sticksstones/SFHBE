//
//  Projectile.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/10/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "Projectile.h"

#define PARAMS_HP 0
#define PARAMS_SP 1
#define PARAMS_AP 2
#define PARAMS_SPRITE 3

#define SHOT_DELAY 2.0

#define ATTACK_DISTANCE 5.0
#define MOVE_DISTANCE 0.0
#define kHealthTag 1
#define kAPTag 2


@implementation Projectile

- (Projectile*)newProjectile:(NSArray*)params {
  self = (Projectile*)[super newShip:params];  
  return self;
}


- (void)onContact {
  
}

- (void)attack {
  if (attackTarget != nil) {
    [self onContact];
  }
}


- (void)update {
  CGSize winSize = [[CCDirector sharedDirector] winSize];
  if(hp <= 0 || self.position.x < 0 || self.position.x > winSize.width) {
    [self killShip];
  }
  
  if([self checkAttackAvailable]) {
    [self attack];    
  }
  
  [self move];
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{	
  self.opacity = 255;
}


@end
