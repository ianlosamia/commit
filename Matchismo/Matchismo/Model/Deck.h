//
//  Deck.h
//  Card
//
//  Created by Christian Losamia on 2/17/24.
//

#ifndef Deck_h
#define Deck_h

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard : (Card*)card atTop:(BOOL)atTop; //method to add card on top
-(void)addCard : (Card*)card; //separate, if we do not want card without atTop

-(Card*)drawRandomCard;

@end

#endif /* Deck_h */
 
