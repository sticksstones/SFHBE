//
//  Card.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/4/11.
//  Copyright 2011 sticks+stones games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Player;

@interface Card : CCSprite <CCTargetedTouchDelegate> {
  float rechargeTime;
  float currentCharge;
  bool ready;
  bool held;
  bool isCaptain;
  int playerNum;
  int cost;
  NSString* cardID;
  NSString* type;
  NSDictionary* properties;
  NSDictionary* origParams;
  CGPoint originalLocation;
}

@property (nonatomic) CGPoint originalLocation;
@property (nonatomic) bool held;
@property (nonatomic) bool ready;
@property (nonatomic) bool isCaptain;

@property (nonatomic) int cost;

- (bool)isPlayable;
- (void)playCard:(CGPoint)boardPos;
- (Card*)initWithParams:(NSDictionary*)params;
- (void)setPlayerNum:(int)_playerNum;
- (id)copyCard;
- (id)copyCardDisplay;
- (NSString*)getID;
- (NSString*)getCardType;
- (NSString*)getCardPassiveAbilities;
- (NSString*)getCardTapAbility;
- (void)commitCard:(Player*)player;
- (void)basicDraw;
- (BOOL)containsTouchLocation:(UITouch *)touch;

@end
