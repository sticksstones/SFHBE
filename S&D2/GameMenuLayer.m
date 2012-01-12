//
//  GameMenuLayer.m
//  S&D2
//
//  Created by VINIT AGARWAL on 1/7/12.
//  Copyright (c) 2012 sticks+stones games. All rights reserved.
//

#import "GameMenuLayer.h"
#import "GameLayer.h"
#import "DeckBuilderLayer.h"
#import "DeckSelectLayer.h"
#import "DeckManager.h"
#import "GameObjectManager.h"
#import "CardManager.h"
#import "BoardManager.h"
#import "PlayerManager.h"
#import "PlayerDeckSelectLayer.h"


@implementation GameMenuLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameMenuLayer *layer = [GameMenuLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void)gameStartTapped:(id)sender {
  	[[CCDirector sharedDirector] replaceScene: [PlayerDeckSelectLayer scene]];
}

- (void)deckBuildTapped:(id)sender {
  [[CCDirector sharedDirector] replaceScene: [DeckSelectLayer scene]];
  
}


// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
		self.isTouchEnabled = YES;
    CCMenuItemLabel* gameStart = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Game Start" fontName:@"Helvetica" fontSize:16.0] target:self selector:@selector(gameStartTapped:)];
    
    CCMenuItemLabel* deckBuild = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Build Deck" fontName:@"Helvetica" fontSize:16.0] target:self selector:@selector(deckBuildTapped:)];
    gameStart.position = CGPointMake(0,0);
    deckBuild.position = CGPointMake(0, -60);
    
    CCMenu *gameMenu = [CCMenu menuWithItems:gameStart,deckBuild,nil];
    gameMenu.position = CGPointMake(200, 200);
    [self addChild:gameMenu];
		
    [[DeckManager instance] resetManager];
    [[BoardManager instance] resetManager];
    [[GameObjectManager instance] resetManager];
    [[CardManager instance] resetManager];
    [[PlayerManager instance] resetManager];
    
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

-(void) onEnter
{
	[super onEnter];	
}


- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
	}
}


@end
