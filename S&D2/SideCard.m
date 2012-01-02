//
//  SideCard.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/31/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "SideCard.h"
#import "PlayerManager.h"
#import "Player.h"
#import "GameObjectManager.h"
#import "SideBoardToken.h"

#define kPreview 5


@implementation SideCard

- (id)copyCard {
  return [[SideCard alloc] initWithParams:origParams];
}

- (void)playSideCard:(UITouch*)touch {
  NSString* sprite = [properties objectForKey:@"sprite"];
  SideBoardToken* token = [[SideBoardToken alloc] newSideBoardToken:[NSArray arrayWithObjects:sprite,properties,nil]];
  [token setPlayerNum:playerNum];
  Player* player = [[PlayerManager instance] getPlayer:playerNum];
  if([player attemptSideTokenPlay:token Touch:touch]) {
    [self commitCard:player];    
  }

  
}


- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {	
  //CGPoint touchPoint = [touch locationInView:[touch view]];
  if (held) {
    //touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    [self playSideCard:touch];
    [self runAction:[CCMoveTo actionWithDuration:0.2 position:originalLocation]];
    self.held = false;
    self.opacity = 255;
  }
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
  CGPoint touchPoint = [touch locationInView:[touch view]];
	if (held) {
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];    
    CCSprite* preview = (CCSprite*)[[[GameObjectManager instance] gameLayer] getChildByTag:kPreview+playerNum];
    [preview setPosition:CGPointMake(touchPoint.x, touchPoint.y)];    
    preview.opacity = 255;
  }
}


@end
