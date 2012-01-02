//
//  Player.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/6/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class Deck;
@class Hand;
@class Card;
@class SideBoardToken;

@interface Player : CCNode {
  int mana;
  int playerNum;
  Hand* hand;
  Hand* captain;
  Deck* deck;
  int health;
}

@property (nonatomic) int mana;
@property (nonatomic) int health;

- (void)initialize:(int)_playerNum;
- (void)addMana:(int)amount;
- (void)spendMana:(int)amount;
- (bool)hasEnoughMana:(int)amount;
- (void)drawCardIntoHand;
- (void)setDeck:(Deck*)_deck;
- (void)consumeCard:(Card *)card;
- (BOOL)attemptSideTokenPlay:(SideBoardToken*)token Touch:(UITouch*)touch;
- (void)update;
@end
