//
//  CardDisplay.m
//  S&D2
//
//  Created by VINIT AGARWAL on 1/7/12.
//  Copyright (c) 2012 sticks+stones games. All rights reserved.
//

#import "CardDisplay.h"

#define kNameTag 100


@implementation CardDisplay


- (CardDisplay*)initWithParams:(NSDictionary*)params {
  self = (CardDisplay*)[super initWithParams:params];
  
  [self removeChildByTag:kNameTag cleanup:YES];
  return self;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if (![self containsTouchLocation:touch] ) return NO;
  
  self.held = true;
	return YES;
}



- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {	
  CGPoint touchPoint = [touch locationInView:[touch view]];
  if (held) {
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    [self runAction:[CCMoveTo actionWithDuration:0.2 position:originalLocation]];
    self.held = false;
  }
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
  CGPoint touchPoint = [touch locationInView:[touch view]];
	if (held) {
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    
//    CCSprite* preview = (CCSprite*)[[[GameObjectManager instance] gameLayer] getChildByTag:kPreview+playerNum];
//    [preview setPosition:CGPointMake(touchPoint.x, touchPoint.y)];
  }
}


- (void)draw {
  [self basicDraw];
}

@end
