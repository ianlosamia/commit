//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Christian Losamia on 3/4/24.
//
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardDeck()

@end

@implementation SetCardDeck

-(id)init {
    
    self = [super init];
    
    if(self) {
        for(NSString *color in [SetCard validColors]) {
            for(NSString *symbol in [SetCard validSymbols]) {
                for(NSString *shade in [SetCard validShades]) {
                    for(NSUInteger number = 1; number <=[SetCard maxNumbers]; number++) {
                        SetCard *card = [[SetCard alloc] init];
                        //set up the card according to property
                        card.color = color;
                        card.symbol = symbol;
                        card.shade = shade;
                        card.number = number;
                        [self addCard:card atTop:YES];
                        
                    }
                }
            }
        }
    }
    return self;
}
@end
