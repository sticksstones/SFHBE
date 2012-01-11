//
//  DeckBuilderLayer.h
//  S&D2
//
//  Created by VINIT AGARWAL on 1/7/12.
//  Copyright (c) 2012 sticks+stones games. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "CCTableView.h"
#import "CCMultiColumnTableView.h"

@class Deck;

@interface DeckBuilderLayer : CCLayer<CCTableViewDataSource, CCTableViewDelegate> {
  NSArray* cards;
  NSMutableArray* detailedCards;
  CCTableView* cardList;
  CCMultiColumnTableView* deckGrid;
  Deck* deck;
}

+(CCScene *) scene;

@end
