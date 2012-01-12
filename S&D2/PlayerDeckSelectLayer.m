//
//  PlayerDeckSelectLayer.m
//  S&D2
//
//  Created by VINIT AGARWAL on 1/12/12.
//  Copyright (c) 2012 sticks+stones games. All rights reserved.
//

#import "PlayerDeckSelectLayer.h"
#import "Deck.h"
#import "DeckCell.h"
#import "DeckManager.h"
#import "DeckBuilderLayer.h"
#import "GameMenuLayer.h"
#import "AppDelegate.h"
#import "GameLayer.h"

#define kP1DeckTag 100
#define kP2DeckTag 200
@implementation PlayerDeckSelectLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	PlayerDeckSelectLayer *layer = [PlayerDeckSelectLayer node];
	
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
    decks = [NSMutableArray new];
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Decks.plist"];
    NSMutableDictionary *plistDecks = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if(!plistDecks) {
      plistDecks = [NSMutableDictionary new];
    }
    
    for(NSString* deck in [plistDecks allKeys]) {
      [decks addObject:deck];
    }    
    
    CCMenuItemLabel* newDeckButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Play" fontName:@"Helvetica" fontSize:32.0] target:self selector:@selector(newDeck:)];
    
    CCMenuItemLabel* goBackButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Main Menu" fontName:@"Helvetica" fontSize:32.0] target:self selector:@selector(goBack:)];
    
    goBackButton.position = CGPointMake(-750, 0);
    CCMenu* newDeck = [CCMenu menuWithItems:newDeckButton, goBackButton, nil];
    [self addChild:newDeck];
    newDeck.position = CGPointMake(900, 50);
    
    

    CCLabelTTF* p1Deck = [CCLabelTTF labelWithString:@"P1: " dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica" fontSize:24.0];
    CCLabelTTF* p2Deck = [CCLabelTTF labelWithString:@"P2: " dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica" fontSize:24.0];
    
    p1Deck.color = ccc3(255, 0, 0);
    p2Deck.color = ccc3(0,0,255);
    
    p1Deck.position = CGPointMake(200, 250);
    p2Deck.position = CGPointMake(600, 250);
    
    [self addChild:p1Deck z:0 tag:kP1DeckTag];
    [self addChild:p2Deck z:0 tag:kP2DeckTag];
    
    deckListP1 = [CCTableView tableViewWithDataSource:self size:CGSizeMake(275, 300)];
    [self addChild:deckListP1];
    [deckListP1 reloadData];
    deckListP1.position = CGPointMake(200, 300);    
    deckListP1.tDelegate = self;
    
    deckListP2 = [CCTableView tableViewWithDataSource:self size:CGSizeMake(275, 300)];
    [self addChild:deckListP2];
    [deckListP2 reloadData];
    deckListP2.position = CGPointMake(600, 300);    
    deckListP2.tDelegate = self;

    
	}
	return self;
}

- (void)newDeck:(id)sender {
  [[CCDirector sharedDirector] replaceScene: [GameLayer scene]];        
}

- (void)goBack:(id)sender {
  [[CCDirector sharedDirector] replaceScene: [GameMenuLayer scene]];
}



/**
 * Class to be used in the table. As seen, table supports homogeneous cell type. In addition,
 * all cells must have an equal, fixed size.
 *
 * @param table table to hold the instances of Class
 * @return class of the cell instances
 */
-(Class)cellClassForTable:(CCTableView *)table {
  return [DeckCell class];
}
/**
 * a cell instance at a given index
 *
 * @param idx index to search for a cell
 * @return cell found at idx
 */
-(CCTableViewCell *)table:(CCTableView *)table cellAtIndex:(NSUInteger)idx {
  CCTableViewCell* cell = [table dequeueCell];
  if (cell == nil) {
    cell = [[DeckCell alloc] init];
  }
  
  cell.node = [CCLabelTTF labelWithString:[decks objectAtIndex:idx] fontName:@"Helvetica" fontSize:16.0];
  
  return cell;    
  
}
/**
 * Returns number of cells in a given table view.
 * 
 * @return number of cells
 */
-(NSUInteger)numberOfCellsInTableView:(CCTableView *)table {
  return [decks count];
}

-(void)table:(CCTableView *)table cellTouched:(CCTableViewCell *)cell {
  CCLabelTTF* deck = (CCLabelTTF*)cell.node;
  Deck* deckObj = [[DeckManager instance] getDeck:deck.string];
  
  if(table == deckListP1) {
    [[DeckManager instance] setP1Deck:deckObj];
    CCLabelTTF* deckName = (CCLabelTTF*)[self getChildByTag:kP1DeckTag];
    [deckName setString:[NSString stringWithFormat:@"P1: %@",[deckObj deckName]]];
  }
  else if(table == deckListP2) {
    [[DeckManager instance] setP2Deck:deckObj];    
    CCLabelTTF* deckName = (CCLabelTTF*)[self getChildByTag:kP2DeckTag];
    [deckName setString:[NSString stringWithFormat:@"P2: %@",[deckObj deckName]]];    
  }

}
-(void)cellRemoved:(CCTableView *)table Removed:(CCTableViewCell *)cell {
  
}


@end
