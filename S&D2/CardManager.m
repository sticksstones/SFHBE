//
//  CardManager.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/6/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "CardManager.h"
#import "Card.h"
#import "SideCard.h"

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
      NSDictionary* plistCards = [plist objectForKey:@"Cards"];
      
      NSMutableDictionary* cards = [NSMutableDictionary new];
      
      NSArray *keys;
      int i, count;
      id key;
      
      keys = [plistCards allKeys];
      count = [keys count];
      for (i = 0; i < count; i++)
      {
        key = [keys objectAtIndex: i];
        NSDictionary* card = [plistCards objectForKey: key];
        [card setValue:key forKey:@"id"];
        id cardObj;
        if([[card valueForKey:@"type"] isEqualToString:@"side"]) {
          cardObj = [[SideCard alloc] initWithParams:card];
        }
        else {
          cardObj = [[Card alloc] initWithParams:card];        
        }

        [cards setObject:cardObj forKey:(NSString*)key];
      }

      gInstance.cards = cards;
    }
  }
  return(gInstance);
}

- (id)getCard:(NSString*)cardID {
  return [[cards objectForKey:cardID] copyCard];
}


@end
