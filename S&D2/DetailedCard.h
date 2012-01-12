//
//  DetailedCard.h
//  S&D2
//
//  Created by VINIT AGARWAL on 1/7/12.
//  Copyright (c) 2012 sticks+stones games. All rights reserved.
//

#import "CCSprite.h"
#import "CCTableViewCell.h"

@class Card;

@interface DetailedCard : CCSprite {
  Card* card;
}

@property (nonatomic, readonly) Card* card;

- (void)setHighlight:(bool)highlight;
- (NSString*)getCardID;
- (DetailedCard*)initWithCard:(Card*)_card;

@end
