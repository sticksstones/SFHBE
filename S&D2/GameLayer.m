//
//  HelloWorldLayer.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/3/11.
//  Copyright sticks+stones games 2011. All rights reserved.
//


// Import the interfaces
#import "GameLayer.h"
#import "GameObjectManager.h"
#import "BoardManager.h"
#import "CardManager.h"
#import "Board.h"
#import "Ship.h"
#import "Card.h"
#import "Deck.h"
#import "DeckManager.h"
#import "Player.h"
#import "PlayerManager.h"
#import "Totem.h"
#import "GameMenuLayer.h"

enum {
	kTagBatchNode = 1,
};


// HelloWorldLayer implementation
@implementation GameLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
		self.isTouchEnabled = YES;

		
    Board* board = [[Board alloc] init];
    [board setupBoardLanes:3 Columns:9];
    
    [[BoardManager instance] setBoard:board];
    [self addChild:board];
    
    [[GameObjectManager instance] setGameLayer:self];
    
    
    Player* p1,*p2;

    p1 = [[Player alloc] init];
    [p1 initialize:1];
    Deck* deck = [[DeckManager instance] p1Deck];
    [deck shuffle];
    [p1 setDeck:deck];
    [p1 setPosition:CGPointMake(250,730)];
    [p1 setRotation:90];

    p2 = [[Player alloc] init];
    [p2 initialize:-1];
    deck = [[DeckManager instance] p2Deck];
    [deck shuffle];
    [p2 setDeck:deck];
    [p2 setPosition:CGPointMake(770, 730)];
    [p2 setRotation:270];
    
    [p1 addMana:75];
    [p2 addMana:75];
    
    [[PlayerManager instance] addPlayer:p1 Num:1];
    [[PlayerManager instance] addPlayer:p2 Num:-1];       
    
    [self addChild:p1];
    [self addChild:p2];
    
    [[GameObjectManager instance] setupTotem:1 X:0 Y:0];
    [[GameObjectManager instance] setupTotem:1 X:0 Y:1];    
    [[GameObjectManager instance] setupTotem:1 X:0 Y:2];    
    [[GameObjectManager instance] setupTotem:-1 X:8 Y:0];    
    [[GameObjectManager instance] setupTotem:-1 X:8 Y:1];    
    [[GameObjectManager instance] setupTotem:-1 X:8 Y:2];    

    
    CCMenuItemLabel* quitGame = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"QUIT" fontName:@"Helvetica" fontSize:16.0] target:self selector:@selector(goBack:)];
    
    CCMenu* gameMenu = [CCMenu menuWithItems:quitGame, nil];
    
    gameMenu.position = CGPointMake([[CCDirector sharedDirector] winSize].width/2, [[CCDirector sharedDirector] winSize].height - 10);
    [self addChild:gameMenu];
    
    
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    
    [frameCache addSpriteFramesWithFile:@"Humans-SpriteSheet.plist"];

    //[[BoardManager instance] spawnMana];
    
    [[PlayerManager instance] drawCards];

		[self schedule: @selector(step:)];
	}
	return self;
}

- (void)goBack:(id)sender {
  [[CCDirector sharedDirector] replaceScene: [GameMenuLayer scene]];

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

-(void) step: (ccTime) delta
{
  [[GameObjectManager instance] update];
}


- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
	}
}
@end
