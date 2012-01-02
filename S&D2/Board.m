//
//  Board.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/4/11.
//  Copyright 2011 sticks+stones games. All rights reserved.
//

#import "Board.h"
#import "GameToken.h"
#import "Tile.h"

#define SIZE_X 900
#define SIZE_Y 300
#define X_OFFSET 115
#define Y_OFFSET 100

#define TILE_RESOLUTION 1

@implementation Board

@synthesize size;

- (void)setupBoardLanes:(int)lanes Columns:(int)columns {
  size = CGSizeMake(SIZE_X, SIZE_Y);
  numLanes = lanes;
  numColumns = columns;
  tiles = [NSMutableDictionary new];

  
  realColumns = columns * TILE_RESOLUTION;
  numColumns = columns * TILE_RESOLUTION;
  
  for(int x = 0; x < numColumns; ++x) {
    for(int y = 0; y < numLanes; ++y) {
      Tile* tile = [Tile spriteWithFile:@"Tile.png"];
      tile.opacity = 128;
      tile.boardX = x;
      tile.boardY = y;
      [tiles setObject:tile forKey:[NSString stringWithFormat:@"%d-%d",x,y]];
      if(x < numColumns/3) {
        [tile setPlayer:1];
      }
      else if(x >= numColumns - numColumns/3) {
        [tile setPlayer:-1];
      }
      [self addChild:tile];      
      [tile setPosition:CGPointMake(X_OFFSET + x*SIZE_X/numColumns, Y_OFFSET + y*SIZE_Y/numLanes)];
    }
  }
}

- (int)getLaneForPixelPos:(int)pixelPos {
  return (int)((pixelPos - Y_OFFSET)/[self getTileDimensions].height);
}

- (int)getPixelPosForLane:(int)lane {
  return (int)([self getTileDimensions].height * lane + Y_OFFSET);
}

- (int)positionToBoardX:(float)position {
  int tile = (int)((position - X_OFFSET)/(SIZE_X/realColumns));
  if (tile >= realColumns || tile < 0) {
    return -1;
  }
  return tile;
}

- (int)positionToBoardY:(float)position {
  int tile = (int)((position - Y_OFFSET)/(SIZE_Y/numLanes));
  if (tile >= numLanes || tile < 0) {
    return -1;
  }
  return tile;
}


- (void)setToken:(GameToken*)token X:(int)x Y:(int)y {
  [token setPosition:CGPointMake(X_OFFSET + x*SIZE_X/realColumns, Y_OFFSET + y*SIZE_Y/numLanes)];
}

- (Tile*)getTileX:(int)x Y:(int)y {
  return [tiles valueForKey:[NSString stringWithFormat:@"%d-%d",x,y]];
}

- (CGSize)getTileDimensions {
  return CGSizeMake(SIZE_X/realColumns, SIZE_Y/numLanes);
}

- (CGRect)convertTileRangeToGameSpaceFrom:(CGPoint)pt1 to:(CGPoint)pt2 {
  CGSize tileSize = [self getTileDimensions];
  CGRect area = CGRectMake(X_OFFSET - tileSize.width/2 + tileSize.width*(pt1.x),Y_OFFSET - tileSize.height/2 + tileSize.height*(pt1.y),tileSize.width*abs(1 + pt2.x - pt1.x),tileSize.height*(1 + pt2.y - pt1.y));
  return area;
}

- (int)getTileSize {
  return (SIZE_X/realColumns);
}

@end
