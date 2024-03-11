//
//  Card.m
//  Card
//
//  Created by Christian Losamia on 2/17/24.
//
#import "Card.h"

@interface Card()
@end

@implementation Card

-(int)match: (NSArray*) otherCards{ //scoring matched cards
    
    int score = 0;
    for (Card* card in otherCards) {
        if([card.contents isEqualToString:self.contents]) {
            score = 1; //score 1 if equals to each other(same strings)
        }
    }

    return score;
}

-(NSUInteger)numberOfMatchingCards {
    if(!_numberOfMatchingCards) {
        _numberOfMatchingCards = 2; //default value (2 cards matching game)
    }
    return _numberOfMatchingCards;
}


@end


/* for-in looping syntax here. This is called “fast enumeration.”
 It works on arrays, dictionaries, etc.
 
*/

