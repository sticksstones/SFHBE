//
//  Hand.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/4/11.
//  Copyright 2011 sticks+stones games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Card;

@interface Hand : CCNode {
  NSMutableArray* cards;
  int playerNum;
}

- (void)initialize:(int)playerNum;
- (bool)AtCapacity;
- (void)addCardToHand:(Card*)card;
- (void)removeCardFromHand:(Card*)card;
- (void)rearrangeCards;
- (void)addCaptains:(NSArray*)captain;
- (void)clearHand;

@end
