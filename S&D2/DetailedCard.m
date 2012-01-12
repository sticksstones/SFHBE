//
//  DetailedCard.m
//  S&D2
//
//  Created by VINIT AGARWAL on 1/7/12.
//  Copyright (c) 2012 sticks+stones games. All rights reserved.
//

#import "DetailedCard.h"
#import "Card.h"

@implementation DetailedCard

@synthesize card;

- (DetailedCard*)initWithCard:(Card*)_card {
  self = [super init];

  float totalY = 0;
  card = _card;
  [self addChild:card];
  
  CCLabelTTF* cardName = [CCLabelTTF labelWithString:[card getID] dimensions:CGSizeMake(100,18) alignment:UITextAlignmentLeft fontName:@"Helvetica" fontSize:14];
  [self addChild:cardName];
  
  totalY += -10 + card.contentSize.height/2 + cardName.contentSize.height/2;
  cardName.position = CGPointMake(15 + card.contentSize.width/2 +cardName.contentSize.width/2, totalY);
  
  CCLabelTTF* cardType = [CCLabelTTF labelWithString:[[card getCardType] uppercaseString] dimensions:CGSizeMake(100,12) alignment:UITextAlignmentLeft fontName:@"Helvetica" fontSize:10];

  [self addChild:cardType];
  
  
  totalY +=  - (5 + cardType.contentSize.height/2);
  cardType.position = CGPointMake(cardName.position.x, totalY);
  
  
  NSString* passiveAbilities = [card getCardPassiveAbilities];
  CCLabelTTF* cardPassiveAbilities = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Traits: %@",passiveAbilities] dimensions:CGSizeMake(100,12) alignment:UITextAlignmentLeft fontName:@"Helvetica" fontSize:10];
  cardPassiveAbilities.color = ccc3(100, 100, 255);
  totalY +=  - (5 + cardType.contentSize.height/2); 
  cardPassiveAbilities.position = CGPointMake(8 + cardType.position.x , totalY);  

  
  
  if(![passiveAbilities isEqualToString:@"None"]) {
    [self addChild:cardPassiveAbilities];  
    totalY +=  - (5 + cardPassiveAbilities.contentSize.height/2);
  }
  NSString* tapAbility = [card getCardTapAbility];
  CCLabelTTF* cardTapAbility = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Ability: %@",tapAbility] dimensions:CGSizeMake(100,12) 
                                alignment:UITextAlignmentLeft fontName:@"Helvetica" fontSize:10];
  cardTapAbility.position = CGPointMake(cardPassiveAbilities.position.x, totalY);
  cardTapAbility.color = ccc3(255,100,100);
  if(![tapAbility isEqualToString:@"None"]) {
    [self addChild:cardTapAbility];  
  }
  
  return self;
}

- (NSString*)getCardID {
  return [card getID];
}

- (void)setHighlight:(bool)highlight {
  card.opacity = highlight ? 100 : 255;
}
@end
