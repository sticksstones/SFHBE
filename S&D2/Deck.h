//
//  Deck.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/6/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "CCNode.h"

@class Card;

@interface Deck : CCNode {
  NSMutableArray* cards;  
  NSMutableArray* graveyard;
  
  NSMutableArray* captain;
  NSArray* origDeckIDs;
  NSArray* origCaptainIDs;  
  int manaCardChance;
}

- (void)initialize:(NSArray*)deck Captain:(NSArray*)captainCards;
- (NSArray*)getCaptain;
- (id)drawCard;
- (void)addCard:(NSString*)card;
- (void)shuffle;
- (Deck*)copyDeck;

@end
