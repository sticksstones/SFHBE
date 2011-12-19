//
//  GameObjectManager.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/3/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class GameToken;
@class Ship;
@class Projectile;

@interface GameObjectManager : NSObject {
  NSMutableArray *gameTokens;
  NSMutableArray *gameTokensToRemove;
  NSMutableArray *gameTokensToAdd;  
  CCLayer* gameLayer;
}

@property (nonatomic, retain) CCLayer* gameLayer;

+ (GameObjectManager *)instance;
- (void)setupTotem:(int)playerNum X:(int)x Y:(int)y;
- (Ship*)createShipPlayerNum:(int)playerNum sprite:(NSString*)sprite;
- (void)killShip:(Ship*)ship;
- (void)addProjectile:(Projectile*)projectile;
- (void)addShip:(Ship*)ship;
- (void)addGameToken:(GameToken*)token;
- (void)removeGameToken:(GameToken*)token;
- (NSMutableArray*)getTokensForLane:(int)lane;
- (GameToken*)getClosestGameTokenTo:(GameToken*)sourceToken enemyOnly:(bool)enemyOnly;
- (NSArray*)getTokensInArea:(CGRect)area;
- (void)update;
- (void)initManager;

@end
