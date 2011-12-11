//
//  BoardManager.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/4/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Board;
@class GameToken;

@interface BoardManager : NSObject {
  Board* board;
}

+ (BoardManager *)instance;
- (void)setBoard:(Board*)_board;
- (Board*)getBoard;
- (void)generateMana;
- (void)updateGameTokenBoardPosition:(GameToken*)token;
- (int)getTileSize;
- (CGPoint)getTileLocForPoint:(CGPoint)point;
- (void)setToken:(GameToken*)token X:(int)x Y:(int)y;
- (bool)isTileOccupiedX:(int)x Y:(int)y;
- (void)spawnManaInRangeXY1:(CGPoint)xy1 XY2:(CGPoint)xy2 playerNum:(int)playerNum;
- (void)spawnMana;
@end
