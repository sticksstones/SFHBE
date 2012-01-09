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

@implementation DeckBuilderLayer

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
        
    CCTableView* tableView = [CCTableView tableViewWithDataSource:self size:CGSizeMake(200, 700)];
    tableView.position = CGPointMake(100, 68);    
    [self addChild:tableView];
    [tableView reloadData];
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

/**
 * Class to be used in the table. As seen, table supports homogeneous cell type. In addition,
 * all cells must have an equal, fixed size.
 *
 * @param table table to hold the instances of Class
 * @return class of the cell instances
 */
-(Class)cellClassForTable:(CCTableView *)table {
  return [DetailedCardCell class];
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
    cell = [[DetailedCardCell alloc] init];
  }
  
  cell.node = [detailedCards objectAtIndex:idx];
  
  return cell;    
}
/**
 * Returns number of cells in a given table view.
 * 
 * @return number of cells
 */
-(NSUInteger)numberOfCellsInTableView:(CCTableView *)table {
  return ([detailedCards count]-1);
}

-(void)table:(CCTableView *)table cellTouched:(CCTableViewCell *)cell {
  
}
-(void)cellRemoved:(CCTableView *)table Removed:(CCTableViewCell *)cell {
  
}



@end
