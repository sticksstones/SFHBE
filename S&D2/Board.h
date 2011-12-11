//
//  Board.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/4/11.
//  Copyright 2011 sticks+stones games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameToken;
@class Tile;

@interface Board : CCSprite {
  int numLanes;
  int numColumns;
  int realColumns;
  NSMutableDictionary* tiles;
  CGSize size;
}

@property CGSize size;

- (void)setupBoardLanes:(int)lanes Columns:(int)columns;
- (int)positionToBoardX:(float)position;
- (int)positionToBoardY:(float)position;
- (void)updateGameTokenBoardPosition:(GameToken*)token;
- (void)removeGameTokenFromBoard:(GameToken*)token;

- (void)setToken:(GameToken*)token X:(int)x Y:(int)y;
- (int)getTileSize;
- (Tile*)getTileX:(int)x Y:(int)y;
@end
