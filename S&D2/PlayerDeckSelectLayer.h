//
//  PlayerDeckSelectLayer.h
//  S&D2
//
//  Created by VINIT AGARWAL on 1/12/12.
//  Copyright (c) 2012 sticks+stones games. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"

#import "CCTableView.h"

@interface PlayerDeckSelectLayer : CCLayer<CCTableViewDataSource, CCTableViewDelegate> {
  NSMutableArray* decks;
  
  CCTableView* deckListP1;
  CCTableView* deckListP2;
  
}

+(CCScene *) scene;
- (void)goBack:(id)sender;
- (void)newDeck:(id)sender;

@end
