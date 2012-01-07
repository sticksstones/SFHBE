//
//  CCAnimationHelper.h
//  AnimationTest
//
//  Created by Ethan Benanav on 1/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCAnimation (CCAnimationHelper)

/**
 * Creates an animation using a "frame", where the frame name is a file imported into Zwoptex
 * @param frame         The name of the frame, minus numbers.
 * @param frameCount    The total frames in this animation
 * @param delay         The delay before this animation plays.
 *
 * @return              The animation.
 */
+(CCAnimation*) animationWithFrame:(NSString*)frame frameCount:(int)frameCount delay:(float)delay;

@end
