//
//  GameToken.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/3/11.
//  Copyright 2011 sticks+stones games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameToken;

@interface GameToken : CCSprite <CCTargetedTouchDelegate> {
  int playerNum;
  int direction;
}

@property int playerNum, direction;

- (void)setupTouch;
- (int)positionRelativeToToken:(GameToken*)token;
- (int)getLane;
- (void)update;
- (void)updateBoardLocation;
- (bool)behindToken:(GameToken*)token;
- (bool)inArea:(CGRect)area;
@end
