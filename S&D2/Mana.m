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

#define EXPIRATION_TIME 10.0

@implementation Mana

- (void)initialize {
  id opacStartup = [CCActionTween actionWithDuration:0.25 key:@"opacity" from:0 to:128];
  id opacOscillateUp = [CCActionTween actionWithDuration:0.4 key:@"opacity" from:128 to:255];
  id opacOscillateDown = [CCActionTween actionWithDuration:0.4 key:@"opacity" from:255 to:128];
  id opacOscillate = [CCRepeatForever actionWithAction:[CCSequence actions:opacOscillateUp,opacOscillateDown,nil]];
  [self runAction:opacStartup];
  [self runAction:opacOscillate];

  id scaleStartup = [CCActionTween actionWithDuration:0.25 key:@"scale" from:0 to:1.0];
  id scaleOscillateUp = [CCActionTween actionWithDuration:0.4 key:@"scale" from:1.0 to:1.25];
  id scaleOscillateDown = [CCActionTween actionWithDuration:0.4 key:@"scale" from:1.25 to:1.0];
  id scaleOscillate = [CCRepeatForever actionWithAction:[CCSequence actions:scaleOscillateUp,scaleOscillateDown,nil]];

  [self runAction:scaleStartup];
  [self runAction:scaleOscillate];

  elapsedTime = 0.0;
  
}


- (CGRect)rectInPixels
{
	CGSize s = [texture_ contentSizeInPixels];
	return CGRectMake(-2.0*s.width / 2, -2.0*s.height / 2, 2.0*s.width, 2.0*s.height);
}

- (CGRect)rect
{
	CGSize s = [texture_ contentSize];
	return CGRectMake(-2.0*s.width / 2, -2.0*s.height / 2, 2.0*s.width, 2.0*s.height);
}

- (void)setupTouch
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
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

- (void)killMana {
  [self removeFromParentAndCleanup:YES];  
}

- (void)draw {
  [super draw];
  elapsedTime += 1.0/60.0;
  if (elapsedTime >= EXPIRATION_TIME) {
      [self runAction:[CCSequence actions:[CCActionTween actionWithDuration:0.25 key:@"opacity" from:self.opacity to:0], [CCCallFunc actionWithTarget:self selector:@selector(killMana)],nil]];    
  }
}


@end
