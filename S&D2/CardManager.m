//
//  CardManager.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/6/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "CardManager.h"
#import "Card.h"

@implementation CardManager

@synthesize cards;

static CardManager *gInstance = NULL;

+ (CardManager *)instance
{
  @synchronized(self)
  {
    if (gInstance == NULL) {
      gInstance = [[self alloc] init];
      NSBundle* bundle = [NSBundle mainBundle];
      NSString* plistFile = [bundle pathForResource:@"CardData" ofType:@"plist"];

      NSMutableDictionary* plist = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFile];
      NSArray* plistCards = [plist objectForKey:@"Cards"];
      
      NSMutableDictionary* cards = [NSMutableDictionary new];
      
      for(NSDictionary* card in plistCards) {
        Card* cardObj = [[Card alloc] initWithParams:card];
        [cards setObject:cardObj forKey:[card valueForKey:@"id"]];          
      }
      gInstance.cards = cards;
    }
  }
  return(gInstance);
}

- (Card*)getCard:(NSString*)cardID {
  return [[cards objectForKey:cardID] copyCard];
}


@end
