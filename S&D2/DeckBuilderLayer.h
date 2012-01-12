//
//  DeckBuilderLayer.h
//  S&D2
//
//  Created by VINIT AGARWAL on 1/7/12.
//  Copyright (c) 2012 sticks+stones games. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "CCMultiColumnTableView.h"

@class Deck;
@class DetailedCard;

@interface DeckBuilderLayer : CCLayer<CCTableViewDataSource, CCTableViewDelegate> {
  NSArray* cards;
  NSMutableArray* detailedCards;
  CCMultiColumnTableView* cardList;
  CCMultiColumnTableView* deckGrid;
  Deck* deck;
  NSString* highlightedLibraryCard;
  NSString* highlightedDeckCard;
  int highlightedDeckCardIdx;
  DetailedCard* previousCard;
  
  CCMenuItemLabel* addToDeck;
  CCMenuItemLabel* removeFromDeck;
  
  CCMenuItemLabel* commander1;
  CCMenuItemLabel* commander2;
  CCMenuItemLabel* commander3;
  
  CCMenuItemLabel* deckSave;
  
  NSMutableArray* captainCards;
}

@property (nonatomic, retain) NSString* highlightedLibraryCard;
@property (nonatomic, retain) NSString* highlightedDeckCard;


-(void)setupCaptains;
-(void)addToDeck:(id)sender;
-(void)removeFromDeck:(id)sender;
-(void)setCommander1:(id)sender;
-(void)setCommander2:(id)sender;
-(void)setCommander3:(id)sender;
-(void)saveDeck:(id)sender;
-(void)deleteDeck:(id)sender;
+(CCScene *) scene;

@end
