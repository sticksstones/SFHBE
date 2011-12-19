//
//  GameToken.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/3/11.
//  Copyright 2011 sticks+stones games. All rights reserved.
//

#import "GameToken.h"
#import "BoardManager.h"

@implementation GameToken

@synthesize playerNum, direction;

- (int)positionRelativeToToken:(GameToken*)token {
  float positionDiff = abs(((int)token.position.x - (int)self.position.x));
  float midPointsOffset = token.contentSize.width/2 + self.contentSize.width/2;
  int trueDist = (int)(positionDiff - midPointsOffset);
  return trueDist;
}

- (int)getLane {
  return [[BoardManager instance] getLaneForPixelPos:(int)self.position.y];
}

- (void)updateBoardLocation {
  //[[BoardManager instance] updateGameTokenBoardPosition:self];
}

- (void)update {
  
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

- (void)setupTouch {
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];  
}

- (void)onEnter
{
  [self setupTouch];
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}	



- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	return [self containsTouchLocation:touch];
}

- (bool)behindToken:(GameToken*)token {
  return ((token.position.x - self.position.x)*playerNum >= 0);
}

@end
