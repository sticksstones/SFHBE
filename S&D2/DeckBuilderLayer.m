//
//  DeckBuilderLayer.m
//  S&D2
//
//  Created by VINIT AGARWAL on 1/7/12.
//  Copyright (c) 2012 sticks+stones games. All rights reserved.
//

#import "DeckBuilderLayer.h"
#import "DetailedCard.h"
#import "CardManager.h"
#import "DetailedCardCell.h"
#import "CardDisplay.h"
#import "CCMultiColumnTableView.h"
#import "Deck.h"
#import "DeckManager.h"
#import "CardCell.h"
#import "CCTableViewCell.h"
#import "GameMenuLayer.h"

#define DECK_MAX_CARDS 15
#define DECK_MAX_CAPTAIN 3

#define kCardCount 100
#define kCaptainCount 200

@implementation DeckBuilderLayer

@synthesize highlightedLibraryCard, highlightedDeckCard;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	DeckBuilderLayer *layer = [DeckBuilderLayer node];
	
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
    cards = [[CardManager instance] getAllDisplayCards];
    detailedCards = [NSMutableArray new];
    for (CardDisplay* card in cards) {
      [detailedCards addObject:[[DetailedCard alloc] initWithCard:card]];
    }
    
    // DeckBuilder Background
    CCSprite* bg = [CCSprite spriteWithFile:@"DeckBuilderBG.png"];
    [self addChild:bg];
    bg.position = CGPointMake([[CCDirector sharedDirector] winSize].width/2, [[CCDirector sharedDirector] winSize].height/2);
    
    
    
    // Library
    cardList = [CCMultiColumnTableView tableViewWithDataSource:self size:CGSizeMake(275, 700)];
    cardList.position = CGPointMake(50, 68);    
    cardList.tDelegate = self;
    [self addChild:cardList];
    [cardList reloadData];
    cardList.colCount = 0;
    cardList.direction = CCScrollViewDirectionVertical;
    deck = [[DeckManager instance] deckBuilderDeck];
    // Deck Grid
    deckGrid = [CCMultiColumnTableView tableViewWithDataSource:self size:CGSizeMake(275, 300)];
    [self addChild:deckGrid];
    [deckGrid reloadData];
    deckGrid.position = CGPointMake(500, 190);    
    deckGrid.tDelegate = self;
    deckGrid.colCount = 0;
    deckGrid.direction = CCScrollViewDirectionVertical;
    
    
    // Deck Builder Controls
    addToDeck = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"+" fontName:@"Helvetica" fontSize:40.0] target:self selector:@selector(addToDeck:)];
    [addToDeck setColor:ccc3(0,255,0)];
    
    removeFromDeck = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"-" fontName:@"Helvetica" fontSize:64.0] target:self selector:@selector(removeFromDeck:)];
    [removeFromDeck setColor:ccc3(255,0,0)];
    addToDeck.position = CGPointMake(0,0);
    removeFromDeck.position = CGPointMake(0, -100);
    
    [addToDeck setIsEnabled:NO];
    [removeFromDeck setIsEnabled:NO];
    
    CCMenu *deckBuilderControls = [CCMenu menuWithItems:addToDeck,removeFromDeck,nil];
    deckBuilderControls.position = CGPointMake(350, 450);
    [self addChild:deckBuilderControls];

    
    // Captain Builder Controls
    commander1 = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Set" fontName:@"Helvetica" fontSize:24.0] target:self selector:@selector(setCommander1:)];
    [commander1 setColor:ccc3(0,255,0)];
    
    commander2 = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Set" fontName:@"Helvetica" fontSize:24.0] target:self selector:@selector(setCommander2:)];
    [commander2 setColor:ccc3(0,255,0)];
    commander2.position = CGPointMake(200,0);

    commander3 = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Set" fontName:@"Helvetica" fontSize:24.0] target:self selector:@selector(setCommander3:)];
    [commander3 setColor:ccc3(0,255,0)];
    commander3.position = CGPointMake(400,0);
    
    [commander1 setIsEnabled:NO];
    [commander2 setIsEnabled:NO];    
    [commander3 setIsEnabled:NO];
    
    CCMenu *captainBuilderControls = [CCMenu menuWithItems:commander1,commander2,commander3,nil];
    captainBuilderControls.position = CGPointMake(400, 590);
    [self addChild:captainBuilderControls];

    
    // Deck Save Button
    deckSave = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Save" fontName:@"Helvetica" fontSize:24.0] target:self selector:@selector(saveDeck:)];
    [deckSave setColor:ccc3(0,255,0)];
    CCMenuItemLabel* deckDelete = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Delete" fontName:@"Helvetica" fontSize:24.0] target:self selector:@selector(deleteDeck:)];
    [deckDelete setColor:ccc3(255,0,0)];
    CCMenuItemLabel* goBack = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Main Menu" fontName:@"Helvetica" fontSize:24.0] target:self selector:@selector(goBack:)];
    [goBack setColor:ccc3(255,255,255)];
    
    CCMenu *deckSaveMenu = [CCMenu menuWithItems:goBack, deckDelete,deckSave,nil];
    
    goBack.position = CGPointMake(0, 100);
    deckDelete.position = CGPointMake(0, 50);
    deckSaveMenu.position = CGPointMake(900, 30);
    
    
    [deckSave setIsEnabled:YES];
    [self addChild:deckSaveMenu];
    
    // Card Count
    CCLabelTTF* cardCount = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Deck (%d/%d)",[[deck cards] count],DECK_MAX_CARDS] fontName:@"Helvetica" fontSize:16.0];
    
    [self addChild:cardCount z:1 tag:kCardCount];        
    cardCount.position = CGPointMake(deckGrid.position.x + deckGrid.contentSize.width/2, deckGrid.position.y - 85);

    // Captains
    captainCards = [NSMutableArray new];
    [self setupCaptains];
    
    // Captain Count
    CCLabelTTF* captainCount = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Captain",[[deck captain] count],DECK_MAX_CAPTAIN] fontName:@"Helvetica" fontSize:16.0];
    
    [self addChild:captainCount z:1 tag:kCaptainCount];
    captainCount.position = CGPointMake(400, 700);
    //[deck initialize:[NSArray new] Captain:[NSArray new]];
    
	}
	return self;
}

- (void)setupCaptains {
  float x = 400;
  for(DetailedCard* captain in captainCards) {
    [self removeChild:captain cleanup:YES];
  }
  
  [captainCards removeAllObjects];
  
  for(NSString* captain in [deck captain]) {
    DetailedCard* captainCard = [[DetailedCard alloc] initWithCard:[[CardManager instance] getDisplayCard:captain]];
    [self addChild:captainCard];
    [captainCards addObject:captainCard];
    captainCard.position = CGPointMake(x,650);
    x += 200;      
  }
  [self cleanup];

}

- (void)setHighlightedLibraryCard:(NSString *)_highlightedLibraryCard {
  highlightedLibraryCard = _highlightedLibraryCard;
  if(highlightedLibraryCard) {
    [addToDeck setIsEnabled:(YES && [[deck cards] count] < DECK_MAX_CARDS)];
    [removeFromDeck setIsEnabled:NO];
    [commander1 setIsEnabled:YES];
    [commander2 setIsEnabled:YES];
    [commander3 setIsEnabled:YES];    
  }
  else {
    [commander1 setIsEnabled:NO];
    [commander2 setIsEnabled:NO];
    [commander3 setIsEnabled:NO];    
    
  }
}

- (void)setHighlightedDeckCard:(NSString *)_highlightedDeckCard {
  highlightedDeckCard = _highlightedDeckCard;
  if(highlightedDeckCard) {
    [addToDeck setIsEnabled:NO];
    [removeFromDeck setIsEnabled:YES];
  }
  else {
    [removeFromDeck setIsEnabled:NO];
  }
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

- (DetailedCard*)getCaptainCardTouch:(UITouch*)touch {
  for(DetailedCard* captain in captainCards) {
    if([[captain card] containsTouchLocation:touch])
      return captain;
  }
  return nil;
}


- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
    DetailedCard* captainCard = [self getCaptainCardTouch:touch];
//    if(captainCard) {
//      [captainCard setHighlight:YES];
//    }
	}
}

/**
 * Class to be used in the table. As seen, table supports homogeneous cell type. In addition,
 * all cells must have an equal, fixed size.
 *
 * @param table table to hold the instances of Class
 * @return class of the cell instances
 */
-(Class)cellClassForTable:(CCTableView *)table {
  if(table == deckGrid) {
    return [DetailedCardCell class];
  }
  else if (table == cardList) {
    return [DetailedCardCell class];
  }
  
  return [DetailedCardCell class];
}
/**
 * a cell instance at a given index
 *
 * @param idx index to search for a cell
 * @return cell found at idx
 */
-(CCTableViewCell *)table:(CCTableView *)table cellAtIndex:(NSUInteger)idx {
  if(table == deckGrid) {
    CCTableViewCell* cell = [table dequeueCell];
    if (cell == nil) {
      cell = [[DetailedCardCell alloc] init];
    }
    
    cell.node = [[DetailedCard alloc] initWithCard:[[CardManager instance] getDisplayCard:[[deck cards] objectAtIndex:idx]]];
    
    return cell;    
  }
  else if(table == cardList) {
    CCTableViewCell* cell = [table dequeueCell];
    if (cell == nil) {
      cell = [[DetailedCardCell alloc] init];
    }
    
    cell.node = [detailedCards objectAtIndex:idx];
    
    return cell;    
  }
  return nil;
}
/**
 * Returns number of cells in a given table view.
 * 
 * @return number of cells
 */
-(NSUInteger)numberOfCellsInTableView:(CCTableView *)table {
  if(table == deckGrid) {
    return [[deck cards] count];
  }
  else if(table == cardList) {
    return ([detailedCards count]);
  }
  return 0;
}

-(void)table:(CCTableView *)table cellTouched:(CCTableViewCell *)cell {
  if(table == cardList) {
    self.highlightedLibraryCard = [((DetailedCard*)(cell.node)) getCardID];
    
    if(previousCard) {
      [previousCard setHighlight:NO];
    }
    
    DetailedCard* card = (DetailedCard*)(cell.node);
    [card setHighlight:YES];
    previousCard = card;
    //[self addToDeck:];
  }
  else if(table == deckGrid) {
    self.highlightedDeckCard = [((DetailedCard*)(cell.node)) getCardID];
    highlightedDeckCardIdx = cell.idx;
    if(previousCard) {
      [previousCard setHighlight:NO];
    }
    
    DetailedCard* card = (DetailedCard*)(cell.node);
    [card setHighlight:YES];
    previousCard = card;    
  }
}
-(void)cellRemoved:(CCTableView *)table Removed:(CCTableViewCell *)cell {
  
}

-(void)addToDeck:(id)sender {
  if(highlightedLibraryCard) {
    [deck addCard:highlightedLibraryCard];  
    [deckGrid reloadData];
    [deckGrid setContentOffset:CGPointMake(0,0) animated:YES];
    [addToDeck setIsEnabled:([[deck cards] count] < DECK_MAX_CARDS)];
    CCLabelTTF* cardCount = (CCLabelTTF*)[self getChildByTag:kCardCount];
    cardCount.string = [NSString stringWithFormat:@"Deck (%d/%d)",[[deck cards] count],DECK_MAX_CARDS];
  }  
}

-(void)removeFromDeck:(id)sender {
  if(highlightedDeckCard) {
    [[deck cards] removeObjectAtIndex:highlightedDeckCardIdx];
    [deckGrid reloadData];    
    highlightedDeckCardIdx--;
    if(highlightedDeckCardIdx < 0) highlightedDeckCardIdx = 0;
    CCTableViewCell* cell = [deckGrid _cellWithIndex:highlightedDeckCardIdx];
    if(cell) {
      [self table:deckGrid cellTouched:cell];
    }
    else {
      self.highlightedDeckCard = nil;
    }
    [addToDeck setIsEnabled:([addToDeck isEnabled] && [[deck cards] count] < DECK_MAX_CARDS)];
    CCLabelTTF* cardCount = (CCLabelTTF*)[self getChildByTag:kCardCount];
    cardCount.string = [NSString stringWithFormat:@"Deck (%d/%d)",[[deck cards] count],DECK_MAX_CARDS];

  }
  
}

-(void)setCommander1:(id)sender {
  [[deck captain] removeObjectAtIndex:0];  
  [[deck captain] insertObject:highlightedLibraryCard atIndex:0];

  [self setupCaptains];
  
}
-(void)setCommander2:(id)sender {
  [[deck captain] removeObjectAtIndex:1];  
  [[deck captain] insertObject:highlightedLibraryCard atIndex:1];
  
  [self setupCaptains];
  
}
-(void)setCommander3:(id)sender {
  [[deck captain] removeObjectAtIndex:2];  
  [[deck captain] insertObject:highlightedLibraryCard atIndex:2];
  
  [self setupCaptains];

}

-(void)goBack:(id)sender {
  [[CCDirector sharedDirector] replaceScene: [GameMenuLayer scene]];
}

-(void)saveDeck:(id)sender {
  [deck writeDeckToFile];
  [[CCDirector sharedDirector] replaceScene: [GameMenuLayer scene]];
}

-(void)deleteDeck:(id)sender {
  [deck deleteDeckFromFile];
  [[CCDirector sharedDirector] replaceScene: [GameMenuLayer scene]];
  
}

-(void)scrollViewDidScroll:(CCScrollView *)view {
  
}




@end
