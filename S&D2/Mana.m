//
//  Mana.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/6/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "Mana.h"
#import "PlayerManager.h"
#import "Player.h"

@implementation Mana

- (void)initialize {
  [self runAction:[CCActionTween actionWithDuration:0.25 key:@"scale" from:0.0 to:1.0]];
  [self runAction:[CCActionTween actionWithDuration:0.25 key:@"opacity" from:0 to:128]];  
}

- (void)setManaAmount:(int)_amount {
  amount = _amount;
}

- (void)setPlayerNum:(int)_playerNum {
  playerNum = _playerNum;
  self.color = ccc3(255*(playerNum == 1), 0, 255*(playerNum == -1));
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
  if([super ccTouchBegan:touch withEvent:event]) {
    [[[PlayerManager instance] getPlayer:playerNum] addMana:amount];
    [self removeFromParentAndCleanup:YES];
    return YES;
  }
  return NO;
}


@end
