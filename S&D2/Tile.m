//
//  Tile.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/4/11.
//  Copyright 2011 sticks+stones games. All rights reserved.
//

#import "Tile.h"
#import "Mana.h"

#define kManaTag 1

@implementation Tile

@synthesize boardX, boardY;

- (Tile*)initWithFile:(NSString*)file {
  self = [super initWithFile:file];
  occupants = [NSMutableArray new];
  return self;
}

- (void)draw {
  if([self isOccupied]) {
    self.opacity = 255;
  }
  else {
    self.opacity = 50;
  }
  
  [super draw];
  
}
- (void)setPlayer:(int)player {
  owner = player;
  self.color = ccc3(255*(owner == 1 ? 1 : 0), 0, 255*(owner != 1 ? 1 : 0));                    
}

- (void)addOccupant:(GameToken*)occupant {
  [occupants addObject:occupant];
}
- (void)removeOccupant:(GameToken*)occupant {
  [occupants removeObject:occupant];
}

- (int)getNumOccupants {
  return [occupants count];
}

- (bool)isOccupied {
  return [self getNumOccupants] > 0;
}

- (bool)addMana:(Mana*)mana {
  if([self containsMana]) {
    return NO;
  }
  [self addChild:(CCNode*)mana z:1 tag:kManaTag];

  [mana initialize];
  [mana setPosition:CGPointMake(self.contentSize.width/2, self.contentSize.height/2)];
  return YES;
}

- (bool)containsMana {
  return ([self getChildByTag:kManaTag] != nil);
}

- (NSArray*)getOccupants {
  return occupants;
}

@end
