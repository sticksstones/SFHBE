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
}

@property (nonatomic, retain) NSMutableDictionary* decks;

+ (DeckManager *)instance;
- (Deck*)getDeck:(NSString*)deckID;

@end
