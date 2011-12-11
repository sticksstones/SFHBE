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
  int boardX, boardY;
  int playerNum;
  int direction;
}

@property int playerNum, direction;

- (int)positionRelativeToToken:(GameToken*)token;
- (int)getLanePosition;
- (int)getLane;
- (void)update;
- (void)setBoardLocationX:(int)x Y:(int)y;
- (void)updateBoardLocation;
- (bool)behindToken:(GameToken*)token;
- (CGPoint)getBoardXY;
@end
