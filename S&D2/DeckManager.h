//
//  DeckManager.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/6/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Deck;

@interface DeckManager : NSObject {
  NSMutableDictionary* decks;
  Deck* deckBuilderDeck;
  Deck* p1Deck;
  Deck* p2Deck;
  
}

@property (nonatomic, retain) NSMutableDictionary* decks;
@property (nonatomic, retain) Deck* deckBuilderDeck;
@property (nonatomic, retain) Deck* p1Deck;
@property (nonatomic, retain) Deck* p2Deck;

+ (DeckManager *)instance;
- (Deck*)getDeck:(NSString*)deckID;
- (void)resetManager;

@end
