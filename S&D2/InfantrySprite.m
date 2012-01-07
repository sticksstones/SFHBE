//
//  InfantrySprite.m
//  AnimationTest
//
//  Created by Ethan Benanav on 1/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "InfantrySprite.h"

#import "CCAnimationHelper.h"



#define WEAPON_DEPTH    40
#define HAT_DEPTH       30
#define FACE_DEPTH      20
#define FEET_DEPTH      10
#define BODY_DEPTH      0

#define DELAY           0.0167f

#define IDLE_COUNT      0
#define WALK_COUNT      45
#define ATTACK_COUNT    15
#define HURT_COUNT      2

@implementation InfantrySprite

-(void) cacheAnimationWithFrame:(NSString*)frame forAction:(NSString*)action withCount:(int)frameCount {
    NSString* name = [NSString stringWithFormat:@"%@-%@", frame, action];
    if( [[CCAnimationCache sharedAnimationCache] animationByName:name] == nil )
    {
        CCAnimation* animation =   [CCAnimation animationWithFrame:name frameCount:frameCount delay:DELAY];
        [[CCAnimationCache sharedAnimationCache] addAnimation:animation name:name];
    }
}


-(void) addBodyPartWithFrame:(NSString*)frame atDepth:(int)z withTag:(int)tag
{
    if(frame != nil)
    {
        CCSprite* part = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@-Walk0001.png", frame]];
        [self cacheAnimationWithFrame:frame forAction:@"Walk" withCount:WALK_COUNT];
        [self cacheAnimationWithFrame:frame forAction:@"Attack" withCount:ATTACK_COUNT];
        [self cacheAnimationWithFrame:frame forAction:@"Hurt" withCount:HURT_COUNT];
        [self addChild:part z:z tag:tag];
    }
}

-(id) initWithAnimations:(NSDictionary*)parts
{
	// Loading the Ship's sprite using a sprite frame name (eg the filename)
	if ((self = [super init]))
	{
        partNames = parts;
        [self addBodyPartWithFrame:[parts objectForKey:[NSNumber numberWithInt:HAT_TAG]] atDepth:HAT_DEPTH withTag:HAT_TAG];
        [self addBodyPartWithFrame:[parts objectForKey:[NSNumber numberWithInt:FACE_TAG]] atDepth:FACE_DEPTH withTag:FACE_TAG];
        [self addBodyPartWithFrame:[parts objectForKey:[NSNumber numberWithInt:FEET_TAG]] atDepth:FEET_DEPTH withTag:FEET_TAG];
        [self addBodyPartWithFrame:[parts objectForKey:[NSNumber numberWithInt:WEAPON_TAG]] atDepth:WEAPON_DEPTH withTag:WEAPON_TAG];
        [self addBodyPartWithFrame:[parts objectForKey:[NSNumber numberWithInt:BODY_TAG]] atDepth:BODY_DEPTH withTag:BODY_TAG];
	}
	return self;
}

-(void) runActionWithName:(NSString*)actionName loops:(BOOL)repeat
{
    for(NSNumber* key in [partNames allKeys])
    {
        int tag = [key intValue];
        NSString* partName = [partNames objectForKey:key];
        
        CCAnimation* animation = [[CCAnimationCache sharedAnimationCache] animationByName:[NSString stringWithFormat:@"%@-%@",partName,actionName]];
        CCAnimate* animate = [CCAnimate actionWithAnimation:animation];
        
        CCSprite* partSprite = (CCSprite*)[self getChildByTag:tag];
        if(repeat)
        {
            CCRepeatForever* repeatForever = [CCRepeatForever actionWithAction:animate];
            [partSprite runAction:repeatForever];
        } else 
        {
            [partSprite runAction:animate];
        }
        
    }
}

-(void) walk
{
    [self runActionWithName:@"Walk" loops:YES];
}

-(void) attack
{
    [self runActionWithName:@"Attack" loops:NO];
}

-(void) hurt
{
    [self runActionWithName:@"Hurt" loops:NO];    
}

+(id) infantrySprite:(NSDictionary*)parts
{
	return [[[self alloc] initWithAnimations:parts] autorelease];
}
    
@end
