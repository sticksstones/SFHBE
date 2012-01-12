//
//  PlayerManager.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/7/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Player;
@class Card;

@interface PlayerManager : NSObject {
  NSMutableDictionary* players;
}

@property (nonatomic, retain) NSMutableDictionary* players;

+ (PlayerManager *)instance;
- (void)addPlayer:(Player*)player Num:(int)playerNum;
- (Player*)getPlayer:(int)playerNum;
- (void)drawCards;
- (void)update;
- (void)resetManager;
@end
