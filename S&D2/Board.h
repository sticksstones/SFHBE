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
- (int)getLaneForPixelPos:(int)pixelPos;
- (int)getPixelPosForLane:(int)lane;
- (void)setToken:(GameToken*)token X:(int)x Y:(int)y;
- (CGSize)getTileDimensions;
- (CGRect)convertTileRangeToGameSpaceFrom:(CGPoint)pt1 to:(CGPoint)pt2;
- (int)getTileSize;
- (Tile*)getTileX:(int)x Y:(int)y;
@end
