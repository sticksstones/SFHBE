//
//  SideTile.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/31/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@class SideBoardToken;

@interface SideTile : CCSprite 

- (BOOL)isOccupied;
- (bool)inArea:(CGRect)area;
- (void)addToken:(SideBoardToken*)token;
- (void)destroyToken;
- (BOOL)containsTouchLocation:(UITouch *)touch;
- (void)update;

@end
