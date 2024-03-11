//
//  PlayingCardViewController.m
//  Matchismo
//
//  Created by Christian Losamia on 3/5/24.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardViewController()

@end

@implementation PlayingCardViewController

-(Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

@end
