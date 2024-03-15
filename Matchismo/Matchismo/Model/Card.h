//
//  Header.h
//  Card
//
//  Created by Christian Losamia on 2/17/24.
//
#import <Foundation/Foundation.h>
#ifndef Card_h
#define Card_h

//@import <Foundation/Foundation.h>

@interface Card : NSObject

//properties-instance variables (properties must have setters and getter)
@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isChosen) BOOL chosen; //legal: (nonatomic, getter = isChosesn)
@property (nonatomic, getter = isMatched) BOOL matched;

@property (nonatomic) NSUInteger numberOfMatchingCards;

//-(int)match: (Card*) card;
-(int)match: (NSArray*) otherCards;

@end


#endif /* Card_h */
