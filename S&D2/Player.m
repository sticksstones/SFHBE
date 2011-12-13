//
//  Player.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/6/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#define kManaTag 1

#define MAX_HEALTH 2

#import "Player.h"

#import "Card.h"
#import "Deck.h"
#import "Hand.h"

@implementation Player

@synthesize mana,health;

- (void)initialize:(int)_playerNum {
  health = MAX_HEALTH;
  hand = [[Hand alloc] init];
  [hand initialize:_playerNum];
  captain = [[Hand alloc] init];
  [captain initialize:_playerNum];
  playerNum = _playerNum;
  if(playerNum == 1) {
    [hand setPosition:CGPointMake(20.0, -70)];
    [captain setPosition:CGPointMake(20.0, -30)];
  }
  else {
    [hand setPosition:CGPointMake(-150.0, -70)];
    [captain setPosition:CGPointMake(-150.0, -30)];
  }
  [self addChild:hand];
  [self addChild:captain];
  self.mana = 0;
  
  CCLabelTTF* manaLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",mana] fontName:@"Helvetica" fontSize:24];
  [self addChild:manaLabel z:1 tag:kManaTag];
  [manaLabel setPosition:CGPointMake(0.0, 75.0)];
}

- (void)setMana:(int)_mana {
  mana = _mana;
  CCLabelTTF* manaLabel = (CCLabelTTF*)[self getChildByTag:kManaTag];
  
  [manaLabel runAction:[CCSequence actions:[CCActionTween actionWithDuration:0.25 key:@"scale" from:1 to:1.5],[CCActionTween actionWithDuration:0.25 key:@"scale" from:1.5 to:1],nil]];

  [manaLabel setString:[NSString stringWithFormat:@"%d",mana]];
}

- (void)addMana:(int)amount {
  if(amount > 0) {
    self.mana += amount;
  }
}
- (void)spendMana:(int)amount {
  if([self hasEnoughMana:amount]) {
    self.mana -= amount;
  }
}
- (bool)hasEnoughMana:(int)amount {
  return mana >= amount;
}

- (void)drawCardIntoHand {
  if (![hand AtCapacity]) {
    Card* card = [deck drawCard];
    [hand addCardToHand:card];
  }
}

- (void)setDeck:(Deck*)_deck {
  deck = _deck;
  [captain addCaptains:[deck getCaptain]];  
}

- (void)consumeCard:(Card *)card {
  [hand removeCardFromHand:card];
  [deck addCard:[card getID]];
}


@end
