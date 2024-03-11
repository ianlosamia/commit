//
//  Deck.m
//  Card
//
//  Created by Christian Losamia on 2/17/24.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards; // of Card cards[];
@end

@implementation Deck

-(NSMutableArray*)cards {
    
    //heap alloc is in the getter for cards ^ property
    if(!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

-(void)addCard:(Card*)card atTop:(BOOL)atTop {
    
    if(atTop) {
        [self.cards insertObject:card atIndex:0]; //add card at top
    } else {
        [self.cards addObject:card]; //bottom
    }
}

-(void)addCard:(Card*)card {
    [self addCard:card atTop:NO]; //add card but not at top
}

- (Card*)drawRandomCard {
    
    Card *randomCard = nil;
    
    if([self.cards count]) {
        unsigned index = arc4random() % [self.cards count]; //return random number at maximum nuber of cards
        randomCard = self.cards[index]; //store value to randomcard
        [self.cards removeObjectAtIndex:index];  //remove the selected card
    }

    
    return randomCard;
}

@end
