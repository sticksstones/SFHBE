//
//  Hand.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/4/11.
//  Copyright 2011 sticks+stones games. All rights reserved.
//

#import "Hand.h"
#import "Card.h"
#import "CardManager.h"

#define MAX_HAND_SIZE 3

@implementation Hand

- (void)initialize:(int)_playerNum {
  playerNum = _playerNum;
  cards = [NSMutableArray new];
}
- (bool)AtCapacity {
  return [cards count] >= MAX_HAND_SIZE;
}

- (void)rearrangeCards {
  float spacing = 25.0;
  int x = 0;
  
  for(Card* card in [self children]) {
    CGPoint newPos = CGPointMake(self.position.x + (card.contentSize.width + spacing)*x, self.position.y);
    [card runAction:[CCMoveTo actionWithDuration:0.15 position:newPos]];
    [card setOriginalLocation:newPos];

    x++;
  }
}

- (void)removeCardFromHand:(Card*)card {
  [cards removeObject:card];
  [self removeChild:card cleanup:YES];
  [self rearrangeCards];
}
- (void)addCardToHand:(Card*)card {
  if(card) {
    [card setPlayerNum:playerNum];
    [cards addObject:card];
    [self addChild:card];
    [self rearrangeCards];

  }
}

- (void)addCaptains:(NSArray*)captain {
  [self clearHand];
  for(NSString* card in captain) {
    Card* cardObj = [[CardManager instance] getCard:card];
    [cardObj setIsCaptain:YES];    
    if (cardObj) {
      [self addCardToHand:cardObj]; 
    }
  }
}

- (void)clearHand {
  for(Card* card in cards) {
    [cards removeObject:card];
    [self removeChild:card cleanup:YES];
  }  
}



@end
