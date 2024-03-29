//
//  Deck.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/6/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "Deck.h"
#import "Card.h"
#import "CardManager.h"
#import "SideCard.h"

@implementation Deck

@synthesize captain,cards,deckName;

- (void)initialize:(NSArray*)deck Captain:(NSArray*)captainCards {
  cards = [NSMutableArray new];
  graveyard = [NSMutableArray new];
  captain = [NSMutableArray new];  
  for(NSString* card in deck) {
    NSMutableString* copy = [[NSMutableString alloc] initWithString:card];
    [cards addObject:copy];
  }
  
  for(NSString* card in captainCards) {
    NSMutableString* copy = [[NSMutableString alloc] initWithString:card];
    [captain addObject:copy];
  }
  manaCardChance = 0;
  
  origDeckIDs = [[NSArray alloc] initWithArray:cards];
  origCaptainIDs = [[NSArray alloc] initWithArray:captain];
}

- (Deck*)copyDeck {
  Deck* deck = [[Deck alloc] init];
  [deck initialize:origDeckIDs Captain:origCaptainIDs];
  [deck setDeckName:deckName];
  return deck;
}

- (NSArray*)getCaptain {
  return captain;  
}


- (id)drawCard {
  if ([cards count] > 0) {
    int manaRoll = arc4random() % 99;
    if (manaRoll <= manaCardChance) {
      manaCardChance = 0;
      SideCard* card = [[CardManager instance] getCard:@"Mana"];
      return card;
    }
    else {
      manaCardChance += 20;
      NSString* card = [cards objectAtIndex:0];
      [cards removeObjectAtIndex:0];
      //[graveyard addObject:card];
      return [[CardManager instance] getCard:card];      
    }
  }
  else {
    [cards addObjectsFromArray:graveyard];
    [self shuffle];
    [graveyard removeAllObjects];
  }
  return nil;
}

- (void)putInGraveyard:(NSString *)card {
  [graveyard addObject:card];
}
- (void)addCard:(NSString*)card {
  [cards insertObject:card atIndex:0];
}

- (void)removeCard:(NSString*)card {
  [cards removeObject:card];
}

- (void)shuffle {
  NSMutableArray* newCardOrder = [NSMutableArray new];
  do {
    int r = arc4random() % [cards count];
    NSString* card = [cards objectAtIndex:r];
    [newCardOrder addObject:[[NSMutableString alloc] initWithString:card]];
    [cards removeObjectAtIndex:r];    
  } while ([cards count] > 0);
  
  cards = newCardOrder;
  
}

- (void)writeDeckToFile {
  NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Decks.plist"];
  //NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Decks" ofType:@"plist"];
  NSMutableDictionary *decks = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
  if(!decks) {
    decks = [NSMutableDictionary new];
  }
  NSMutableDictionary* deck = [NSMutableDictionary new];
  [deck setObject:captain forKey:@"Captain"];
  [deck setObject:cards forKey:@"Cards"];
  
  [decks setObject:deck forKey:deckName];
  [decks writeToFile:plistPath atomically:YES];
}

- (void)deleteDeckFromFile {
  NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Decks.plist"];
  NSMutableDictionary *decks = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
  if(decks) {
    [decks removeObjectForKey:deckName];
    [decks writeToFile:plistPath atomically:YES];
  }
}

@end
