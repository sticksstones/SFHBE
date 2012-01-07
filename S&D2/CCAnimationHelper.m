//
//  CCAnimationHelper.m
//  AnimationTest
//
//  Created by Ethan Benanav on 1/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CCAnimationHelper.h"

@implementation CCAnimation (CCAnimationHelper)

+(CCAnimation*) animationWithFrame:(NSString*)frame frameCount:(int)frameCount delay:(float)delay
{
	// load the ship's animation frames as textures and create a sprite frame
	NSMutableArray* frames = [NSMutableArray arrayWithCapacity:frameCount];
	for (int i = 1; i <= frameCount; ++i)
	{
		NSString* file = [NSString stringWithFormat:@"%@%04i.png", frame, i];
		CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
		CCSpriteFrame* spriteFrame = [frameCache spriteFrameByName:file];
		[frames addObject:spriteFrame];
	}
	
	// return an animation object from all the sprite animation frames
	return [CCAnimation animationWithFrames:frames delay:delay];
}

@end
