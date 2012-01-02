//
//  SideBoardToken.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/31/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "CCSprite.h"

@interface SideBoardToken : CCSprite {
  int playerNum;
  NSMutableDictionary* passiveAbilities;
}

@property int playerNum;

- (SideBoardToken*)newSideBoardToken:(NSArray*)params;
- (void)addPassiveAbility:(id)ability step:(NSString*)step;
- (void)update;

@end
