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
  NSString* deckName;
  NSMutableArray* captain;
  NSArray* origDeckIDs;
  NSArray* origCaptainIDs;  
  int manaCardChance;
}

@property (nonatomic, retain) NSMutableArray* cards;
@property (nonatomic, retain) NSMutableArray* captain;
@property (nonatomic, retain) NSString* deckName;

- (void)initialize:(NSArray*)deck Captain:(NSArray*)captainCards;
- (NSArray*)getCaptain;
- (id)drawCard;
- (void)addCard:(NSString*)card;
- (void)shuffle;
- (Deck*)copyDeck;
- (void)removeCard:(NSString*)card;
- (void)writeDeckToFile;
- (void)deleteDeckFromFile;
@end
