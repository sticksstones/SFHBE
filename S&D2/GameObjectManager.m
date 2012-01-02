//
//  GameObjectManager.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/3/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "GameObjectManager.h"
#import "GameToken.h"
#import "Ship.h"
#import "BoardManager.h"
#import "Board.h"
#import "Tile.h"
#import "PlayerManager.h"
#import "Player.h"
#import "Totem.h"
#import "Projectile.h"

@implementation GameObjectManager

@synthesize gameLayer;

static GameObjectManager *gInstance = NULL;

+ (GameObjectManager *)instance
{
  @synchronized(self)
  {
    if (gInstance == NULL) {
      gInstance = [[self alloc] init];
      [gInstance initManager];
    }
  }
  return(gInstance);
}

- (void)initManager {
  gameTokens = [NSMutableArray new];
  gameTokensToRemove = [NSMutableArray new];
  gameTokensToAdd = [NSMutableArray new];
}

- (void)purgeTokens {
  for (GameToken* token in gameTokensToRemove) {
    [gameTokens removeObject:token];
    [gameLayer removeChild:token cleanup:YES];

  }
  
  [gameTokensToRemove removeAllObjects];  
}

- (void)addNewTokens {
  for (GameToken* token in gameTokensToAdd) {
    [gameTokens addObject:token];
  }
  [gameTokensToAdd removeAllObjects];
}

- (void)updateTokens {
  for (GameToken* token in gameTokens) {
    [token update];
  }
  
  for (GameToken* token in gameTokens) {
    [token updateBoardLocation];
  }

}

- (void)update {
  [self purgeTokens];
  [self addNewTokens];
  [self updateTokens];
  [[PlayerManager instance] update];
}

- (void)addProjectile:(Projectile*)projectile {
  [self addGameToken:projectile];
  [gameLayer addChild:projectile];
}

- (void)addShip:(Ship*)ship {
  [self addGameToken:ship];
  [gameLayer addChild:ship];
}

- (Ship*)createShipPlayerNum:(int)playerNum sprite:(NSString*)sprite {
  Ship* ship = [[Ship alloc] newShip:[NSArray arrayWithObjects:[NSNumber numberWithInt:10],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],sprite,nil]];
  [self addGameToken:ship];
  [ship setPlayerNum:playerNum];
  [gameLayer addChild:ship];
  return ship;
}

- (void)killShip:(Ship*)ship {
  [self removeGameToken:ship];
}

- (void)addGameToken:(GameToken*)token {
  [gameTokensToAdd addObject:token];
}

- (void)removeGameToken:(GameToken*)token {
  [gameTokensToRemove addObject:token];
}

- (NSMutableArray*)getTokensForLane:(int)lane {
  NSMutableArray* tokensInLane = [NSMutableArray new];
  int pixelPos = [[BoardManager instance] getPixelPosForLane:lane];
  
  for (GameToken* token in gameTokens) {
    if (pixelPos == (int)([token position].y)) {
      [tokensInLane addObject:token];
    }
  }
  
  return tokensInLane;
}

- (GameToken*)getClosestGameTokenTo:(GameToken*)sourceToken enemyOnly:(bool)enemyOnly {
  NSArray* tokensInLane = [self getTokensForLane:[sourceToken getLane]];
  
  GameToken* closestToken = nil;
  
  for (GameToken* token in tokensInLane) {
    if (token != sourceToken) {      
      if ([sourceToken behindToken:token] && (closestToken == nil || ([token positionRelativeToToken:sourceToken] < [closestToken positionRelativeToToken:sourceToken]))) {
        if (!enemyOnly || (enemyOnly && [token playerNum] != [sourceToken playerNum])) {
          closestToken = token;
        }
      }    
    }
  }
  
  
  return closestToken;
}

- (NSArray*)getTokensInArea:(CGRect)area {
  NSMutableArray* tokensInArea = [NSMutableArray new];
  for (GameToken* token in gameTokens) {
    if ([token inArea:area]) {
      [tokensInArea addObject:token];      
    }
  }
  return tokensInArea;
}

- (void)setupTotem:(int)playerNum X:(int)x Y:(int)y {
  Totem* totem;
  int totemHP = 10;
  int totemSP = 0;
  int totemAP = 1;
  
  
  totem = [[Totem alloc] newTotem:[NSArray arrayWithObjects:[NSNumber numberWithInt:totemHP],[NSNumber numberWithInt:totemSP],[NSNumber numberWithInt:totemAP],@"Totem.png", nil]];
  
  [self addGameToken:totem];
  [totem setPlayerNum:playerNum];
  [gameLayer addChild:totem];
  
  [[BoardManager instance] setToken:totem X:x Y:y];
  totem.position = CGPointMake(totem.position.x - totem.playerNum*75, totem.position.y);
  //[[BoardManager instance] updateGameTokenBoardPosition:totem];  

}

@end
