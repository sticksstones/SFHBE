//
//  DeckSelectLayer.m
//  S&D2
//
//  Created by VINIT AGARWAL on 1/12/12.
//  Copyright (c) 2012 sticks+stones games. All rights reserved.
//

#import "DeckSelectLayer.h"
#import "Deck.h"
#import "DeckCell.h"
#import "DeckManager.h"
#import "DeckBuilderLayer.h"
#import "GameMenuLayer.h"
#import "AppDelegate.h"

@implementation DeckSelectLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	DeckSelectLayer *layer = [DeckSelectLayer node];
	
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
    
    CCMenuItemLabel* newDeckButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"New Deck" fontName:@"Helvetica" fontSize:32.0] target:self selector:@selector(newDeck:)];
    
    CCMenuItemLabel* goBackButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Main Menu" fontName:@"Helvetica" fontSize:32.0] target:self selector:@selector(goBack:)];
    
    goBackButton.position = CGPointMake(-750, 0);
    CCMenu* newDeck = [CCMenu menuWithItems:newDeckButton, goBackButton, nil];
    [self addChild:newDeck];
    newDeck.position = CGPointMake(900, 50);
    
    
    
    deckList = [CCTableView tableViewWithDataSource:self size:CGSizeMake(275, 300)];
    [self addChild:deckList];
    [deckList reloadData];
    deckList.position = CGPointMake(400, 300);    
    deckList.tDelegate = self;
    
	}
	return self;
}

- (void)newDeck:(id)sender {
  
  AppDelegate* delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
  [delegate specifyDeckName];
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
  [[DeckManager instance] setDeckBuilderDeck:deckObj];
  [[CCDirector sharedDirector] replaceScene: [DeckBuilderLayer scene]];

  
  
  
}
-(void)cellRemoved:(CCTableView *)table Removed:(CCTableViewCell *)cell {
  
}


@end
