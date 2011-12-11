//
//  Card.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/4/11.
//  Copyright 2011 sticks+stones games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

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

- (void)playCard:(CGPoint)boardPos;
- (Card*)initWithParams:(NSDictionary*)params;
- (void)setPlayerNum:(int)_playerNum;
- (Card*)copyCard;
- (NSString*)getID;

@end
