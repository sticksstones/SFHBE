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
}

- (void)setPlayer:(int)player;
- (bool)containsMana;
- (bool)addMana:(Mana*)mana;

@property int boardX;
@property int boardY;

@end
