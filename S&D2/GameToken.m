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
  return abs([token getLanePosition] - [self getLanePosition]);
}

- (int)getLanePosition {
  return boardX;
}

- (int)getLane {
  return boardY;
}

- (void)setBoardLocationX:(int)x Y:(int)y {
  boardX = x;
  boardY = y;
}

- (void)updateBoardLocation {
  [[BoardManager instance] updateGameTokenBoardPosition:self];
}

- (void)update {
  
}

- (CGRect)rectInPixels
{
	CGSize s = [texture_ contentSizeInPixels];
	return CGRectMake(-1.25*s.width / 2, -1.25*s.height / 2, 1.25*s.width, 1.25*s.height);
}

- (CGRect)rect
{
	CGSize s = [texture_ contentSize];
	return CGRectMake(-1.25*s.width / 2, -1.25*s.height / 2, 1.25*s.width, 1.25*s.height);
}


- (BOOL)containsTouchLocation:(UITouch *)touch
{
	CGPoint p = [self convertTouchToNodeSpaceAR:touch];
	CGRect r = [self rectInPixels];
  
	return CGRectContainsPoint(r, p);
}

- (void)onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
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
  return (([token getLanePosition] - [self getLanePosition])*playerNum > 0);
}

- (CGPoint)getBoardXY {
  return CGPointMake(boardX, boardY);
}

@end
