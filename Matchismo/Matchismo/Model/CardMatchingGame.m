//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Christian Losamia on 2/29/24.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score; //redeclare as not readonly
@property (nonatomic, strong) NSMutableArray *cards; // keep track of cards
@property (nonatomic, readwrite) NSInteger lastScore;
@property (nonatomic, readwrite) NSArray *lastChosenCard;


@end

@implementation CardMatchingGame

-(NSMutableArray *)cards {
    
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (NSUInteger)maxMatchingCards
{
    Card *card = [self.cards firstObject];
    if (_maxMatchingCards < card.numberOfMatchingCards) {
        _maxMatchingCards = card.numberOfMatchingCards;
    }
    return _maxMatchingCards;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    
    self = [super init]; //super's designated initializer as init
    
    if(self) {
        for(int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(void)chooseCardAtIndex:(NSUInteger)index {
    
    //flip card when clicked
    Card *card = [self cardAtIndex:index]; // put card to be chosen to local variable card
    
    if(!card.isMatched) {     //only allow unmatched cards to be chosen
        if(card.isChosen) {       //if card already chosen, unchoose it
            card.chosen = NO;
        
        }
        else { //picking other card/s
            NSMutableArray *otherCards = [NSMutableArray array]; //create array to hold othercard objects
            
            //create and store the other chosen card to array
            for(Card *otherCard in self.cards) {
                if(otherCard.isChosen && !otherCard.isMatched) {
                    [otherCards addObject:otherCard]; //store otherCard to array chosenCards
                }
            }
            self.lastScore = 0;
            self.lastChosenCard = [otherCards arrayByAddingObject:card];
            //match against other chosen cards
            if([otherCards count] + 1 == self.maxMatchingCards) { //
                int matchScore = [card match:otherCards];
                if(matchScore) { //give score
                    self.lastScore = matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for(Card *otherCard in otherCards) {
                        otherCard.matched = YES;
                    }
                }
                else { //else, give penalty
                    self.lastScore = -MISMATCH_PENALTY;
                    for (Card *otherCard in otherCards) {
                        otherCard.matched = NO;
                        otherCard.chosen = NO;
                    }
                }
             }
             self.score += self.lastScore - COST_TO_CHOOSE; //penalty for every flip
             card.chosen = YES; //mark as chosen
            
        }
    }
}

-(Card *)cardAtIndex:(NSUInteger)index {
    
    return (index < [self.cards count]) ? self.cards[index] : nil;
}
 
@end

