//
//  PlayingCard.m
//  Card
//
//  Created by Christian Losamia on 2/17/24.
//

#import "PlayingCard.h"

@interface PlayingCard()
@end
 
@implementation PlayingCard

@synthesize suit = _suit; //setter getter

//initialize setter and getter for properties (start)
-(NSString*)suit {
    
    return _suit ? _suit : @"?"; //override suit getter method for "not yet set" (?) suit
}

-(void)setSuit:(NSString *)suit {
    
    if([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(void)setRank:(NSUInteger)rank {
    
    if (rank <= [PlayingCard maxRank]) {
        
        _rank = rank;
    }
}
//initialize setter and getter for properties (end)

//set valid values for properties (start)
+(NSArray*)validSuits {
    
    return @[@"❤️",@"♦️",@"♠️",@"♣️"];
}

+(NSArray*)rankStrings {  //valid ranks
    
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+(NSUInteger)maxRank {
    
    return [self.rankStrings count] -1;
}
//set valid values for properties (end)

-(int)match:(NSArray *)otherCards {
    
    int score = 0;
    int numberOfOtherCards = [otherCards count];
    
    if(numberOfOtherCards) { // for 2 card match (== 1)
        for(Card *card in otherCards) {
            if([card isKindOfClass:[PlayingCard class]]) {
                PlayingCard *otherCard = (PlayingCard *)card;
                if ([self.suit isEqualToString:otherCard.suit]) {
                    score += 1;
                }
                else if (self.rank == otherCard.rank) {
                    score += 4;
                }
            }
        }
    }
    if (numberOfOtherCards > 1) {
        score += [[otherCards firstObject] match:[otherCards subarrayWithRange:NSMakeRange(1, numberOfOtherCards - 1)]];
    }
    return score;
    
    /*
    else if ([otherCards count] == 2) { //for 3 card match
        
        PlayingCard *card2 = otherCards[0];
        PlayingCard *card3 = otherCards[1];
        
        if(self.rank == card2.rank && self.rank == card3.rank) {
            
            score = 10;
        }
        else if(self.rank == card2.rank || card2.rank == card3.rank || self.rank == card3.rank) {
            
            score = 7;
        }
        
        if([self.suit isEqualToString:card2.suit] && [self.suit isEqualToString:card3.suit]) {
            
            score = 5;
        }
        else if([self.suit isEqualToString:card2.suit] || [self.suit isEqualToString:card3.suit] || [card2.suit isEqualToString:card3.suit]) {
            
            score = 4;
        }
    }*/
}

-(NSString*)contents { //override "contents" method in card class (inheritance)
    
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}



@end
