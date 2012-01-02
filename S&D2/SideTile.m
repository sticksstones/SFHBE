//
//  SideTile.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/31/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "SideTile.h"
#import "SideBoardToken.h"

#define kSideTokenTag 1

@implementation SideTile

- (BOOL)isOccupied {
  return [self getChildByTag:kSideTokenTag] != nil;
}
- (void)addToken:(SideBoardToken*)token {
  [self destroyToken];
  [self addChild:token z:1 tag:kSideTokenTag];
  token.position = CGPointMake(token.contentSize.width/2, token.contentSize.height/2);
}
- (void)destroyToken {
  if([self isOccupied]) {
    [self removeChildByTag:kSideTokenTag cleanup:YES];
  }
}

- (void)update {
  SideBoardToken* token = (SideBoardToken*)[self getChildByTag:kSideTokenTag];
  if(token) {
    [token update];
  }
}

- (CGRect)rectInPixels
{
	CGSize s = [texture_ contentSizeInPixels];
	return CGRectMake(-1.0*s.width / 2, -1.0*s.height / 2, 1.0*s.width, 1.0*s.height);
}

- (CGRect)rect
{
	CGSize s = [texture_ contentSize];
	return CGRectMake(-1.0*s.width / 2, -1.0*s.height / 2, 1.0*s.width, 1.0*s.height);
}


- (BOOL)containsTouchLocation:(UITouch *)touch
{
	CGPoint p = [self convertTouchToNodeSpaceAR:touch];
	CGRect r = [self rectInPixels];
  
	return CGRectContainsPoint(r, p);
}

- (bool)inArea:(CGRect)area {
  return CGRectContainsPoint(area, [self position]);
}


@end
