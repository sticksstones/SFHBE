//
//  Tile.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/4/11.
//  Copyright 2011 sticks+stones games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameToken;
@class Mana;

@interface Tile : CCSprite {
  int boardX;
  int boardY;
  int owner;
  NSMutableArray* occupants;
  
}

- (void)setPlayer:(int)player;
- (void)addOccupant:(GameToken*)occupant;
- (void)removeOccupant:(GameToken*)occupant;
- (NSArray*)getOccupants;
- (int)getNumOccupants;
- (bool)isOccupied;
- (bool)containsMana;
- (bool)addMana:(Mana*)mana;

@property int boardX;
@property int boardY;

@end
