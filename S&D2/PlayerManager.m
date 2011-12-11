//
//  PlayerManager.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/7/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "PlayerManager.h"
#import "Player.h"

#define DRAW_INTERVAL 15.0

@implementation PlayerManager

@synthesize players;

static PlayerManager *gInstance = NULL;

+ (PlayerManager *)instance
{
  @synchronized(self)
  {
    if (gInstance == NULL) {
      gInstance = [[self alloc] init];
      gInstance.players = [NSMutableDictionary new];
    }
  }
  return(gInstance);
}

- (void)addPlayer:(Player*)player Num:(int)playerNum {
  [players setObject:player forKey:[NSString stringWithFormat:@"%d",playerNum]];  
}

- (Player*)getPlayer:(int)playerNum {
  return [players objectForKey:[NSString stringWithFormat:@"%d",playerNum]];
}

- (void)drawCards {
  [[self getPlayer:1] drawCardIntoHand];
  [[self getPlayer:-1] drawCardIntoHand];
  [self performSelector:@selector(drawCards) withObject:nil afterDelay:DRAW_INTERVAL];    
}


@end
