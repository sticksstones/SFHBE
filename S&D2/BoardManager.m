//
//  BoardManager.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/4/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "BoardManager.h"
#import "Board.h"
#import "GameToken.h"
#import "Tile.h"
#import "Mana.h"
#import "GameObjectManager.h"


#define MANA_INTERVAL 12.0
#define MANA_DROP_AMOUNT 25

@implementation BoardManager

static BoardManager *gInstance = NULL;

+ (BoardManager *)instance
{
  @synchronized(self)
  {
    if (gInstance == NULL) {
      gInstance = [[self alloc] init];
    }
  }
  return(gInstance);
}

- (void)setBoard:(Board*)_board {
  board = _board;
}

- (Board*)getBoard {
  return board;
}

- (void)generateMana {
  
}


- (int)getTileSize {
  if(board) {
    return [board getTileSize];
  }
  return 0;
}

- (int)getPixelPosForLane:(int)lane {
  return [board getPixelPosForLane:lane];
}

- (int)getLaneForPixelPos:(int)pixelPos {
  return [board getLaneForPixelPos:pixelPos];
}

- (CGPoint)getTileLocForPoint:(CGPoint)point {
  int x = [board positionToBoardX:point.x];
  int y = [board positionToBoardY:point.y];
  
  return CGPointMake(x, y);
}

- (void)setToken:(GameToken*)token X:(int)x Y:(int)y {
  if(board) {
    [board setToken:token X:x Y:y];
  }
}

- (NSArray*)getTokensForSpot:(CGPoint)spot {
  CGRect area = [board convertTileRangeToGameSpaceFrom:CGPointMake(spot.x,spot.y) to:CGPointMake(spot.x,spot.y)];
  
  NSArray* tokens = [[GameObjectManager instance] getTokensInArea:area];
  return tokens;
}

- (bool)isTileOccupiedX:(int)x Y:(int)y playerNum:(int)pNum enemyOnly:(bool)enemyOnly{
  
  CGRect area = [board convertTileRangeToGameSpaceFrom:CGPointMake(x,y) to:CGPointMake(x,y)];
  
  NSArray* tokens = [[GameObjectManager instance] getTokensInArea:area];
  
  if([tokens count] == 0) {
    return NO;
  }
  else {
    if(enemyOnly) {
      for(GameToken* token in tokens) {
        if(pNum == [token playerNum]) {
          return YES;
        }
        return NO;
      }
    }
    else {      
      return YES;
    }
  }
  return YES;
}

- (void)spawnManaInRangeXY1:(CGPoint)xy1 XY2:(CGPoint)xy2 playerNum:(int)playerNum {
  Mana* mana = [Mana spriteWithFile:@"Mana.png"];
  [mana setManaAmount:MANA_DROP_AMOUNT];
  
  
  [mana setPlayerNum:playerNum];
  NSMutableArray* tiles = [NSMutableArray new];
  
  for(int y = xy1.y; y <= xy2.y; y++) {
    for(int x = xy1.x; x <= xy2.x; ++x) {
      
      [tiles addObject:[NSString stringWithFormat:@"%d,%d",x,y]];      
    }
  }  
  
  while([tiles count] > 0) {
    int tileSelection = arc4random() % [tiles count];
    NSString* tileNum = [tiles objectAtIndex:tileSelection];
    [tiles removeObjectAtIndex:tileSelection];
    NSArray* tileComponents = [tileNum componentsSeparatedByString:@","];
    Tile* tile = [board getTileX:[[tileComponents objectAtIndex:1] intValue] Y:[[tileComponents objectAtIndex:0] intValue]];
    if([tile addMana:mana]) {
      return;
    }
  }
  return;
}

- (void)spawnMana {
  
  [self spawnManaInRangeXY1:CGPointMake(0,1) XY2:CGPointMake(2,2) playerNum:1];
  [self spawnManaInRangeXY1:CGPointMake(0,6) XY2:CGPointMake(2,7) playerNum:-1];  
  [self performSelector:@selector(spawnMana) withObject:nil afterDelay:MANA_INTERVAL];    
  
}

- (void)testArea {
  [board testArea];
}


@end
