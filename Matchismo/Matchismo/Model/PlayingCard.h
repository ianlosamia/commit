//
//  PlayingCard.h
//  Card
//
//  Created by Christian Losamia on 2/17/24.
//

#ifndef PlayingCard_h
#define PlayingCard_h

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray*) validSuits;
+(NSArray*) rankStrings;
+(NSUInteger)maxRank;


@end

#endif /* PlayingCard_h */
