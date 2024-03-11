//
//  SetCard.h
//  Matchismo
//
//  Created by Christian Losamia on 3/4/24.
//

#ifndef SetCard_h
#define SetCard_h
#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic)NSString *color;
@property (strong, nonatomic)NSString *symbol;
@property (strong, nonatomic)NSString *shade;
@property (nonatomic)NSUInteger number;

+(NSArray *)validColors;
+(NSArray *)validSymbols;
+(NSArray *)validShades;
+(NSUInteger)maxNumbers;

+ (NSArray *)createCardFromText:(NSString *)text;
@end

#endif /* SetCard_h */
