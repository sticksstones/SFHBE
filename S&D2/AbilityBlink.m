//
//  AbilityBlink.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/8/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "AbilityBlink.h"
#import "Ship.h"
#import "BoardManager.h"

@implementation AbilityBlink

- (bool)checkCriteria:(NSArray*)params {
  int x = [[params objectAtIndex:0] intValue];
  int y = [[params objectAtIndex:1] intValue];
  return ![[BoardManager instance] isTileOccupiedX:x Y:y];
  
}

- (void)performAbility {
  if([self abilityAvailable]) {
    [self incurCost];    
    Ship* ship = (Ship*)sourceToken;
    
    
    CGPoint pos = CGPointMake(ship.position.x, ship.position.y);
    pos.x = pos.x + ship.playerNum*level*2*[[BoardManager instance] getTileSize];
    
    CGPoint tileLoc = [[BoardManager instance] getTileLocForPoint:pos];
    
    if([self checkCriteria:[NSArray arrayWithObjects:[NSNumber numberWithInt:tileLoc.x],[NSNumber numberWithInt:tileLoc.y], nil]]) {
      [ship setPosition:pos];
      [ship setDirection:ship.playerNum];      
    }
    else {
        //fizzle
    }
    
    [super performAbility];
  }
}


@end
