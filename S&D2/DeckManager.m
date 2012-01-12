//
//  DeckManager.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/6/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "DeckManager.h"
#import "Deck.h"

@implementation DeckManager

@synthesize decks, deckBuilderDeck, p1Deck, p2Deck;

static DeckManager *gInstance = NULL;

+ (DeckManager *)instance
{
  @synchronized(self)
  {
    if (gInstance == NULL) {
      gInstance = [[self alloc] init];
      
      NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Decks.plist"];
      
      NSBundle* bundle = [NSBundle mainBundle];      
      NSString* plistFile = [bundle pathForResource:@"DeckData" ofType:@"plist"];
      
      NSMutableDictionary* plist = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
      
      NSMutableDictionary* decks = [NSMutableDictionary new];
      
      
      NSArray *keys;
      int i, count;
      id key;
      
      keys = [plist allKeys];
      count = [keys count];
      for (i = 0; i < count; i++)
      {
        key = [keys objectAtIndex: i];
        NSDictionary* value = [plist objectForKey: key];
        Deck* deckObj = [[Deck alloc] init];
        [deckObj initialize:[value objectForKey:@"Cards"] Captain:[value objectForKey:@"Captain"]];
        [deckObj setDeckName:[[NSString alloc] initWithString:key]];        
        [decks setObject:deckObj forKey:key];    
      }
      
      gInstance.decks = [[NSMutableDictionary alloc] initWithDictionary:decks];
    }
  }
  return(gInstance);
}


- (Deck*)getDeck:(NSString*)deckID {
  return [[decks objectForKey:deckID] copyDeck];
}

- (void)resetManager {
  gInstance = nil;
}

@end
