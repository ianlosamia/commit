//
//  SetCard.m
//  Matchismo
//
//  Created by Christian Losamia on 3/4/24.
//

#import "SetCard.h"

@implementation SetCard

@synthesize color = _color, symbol = _symbol, shade = _shade;

//setter getter lazy ins (start)
-(NSString *)color {
    return _color ? _color : @"?";
}

-(void)setColor:(NSString *)color {
    if([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

-(NSString *) symbol {
    return _symbol ? _symbol : @"?";
}

-(void)setSymbol:(NSString *)symbol {
    if([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

-(NSString *)shade {
    return _shade ? _shade : @"?";
}

-(void)setShade:(NSString *)shade {
    if([[SetCard validShades] containsObject:shade]) {
        _shade = shade;
    }
}

-(void)setNumber:(NSUInteger)number {
    if(number <= [SetCard maxNumbers]) {
        _number = number;
    }
}
//setter getter lazy ins (end)

//valid values for properties (start)
+ (NSArray *)validColors {
    return @[@"black", @"red", @"blue"];
}

+ (NSArray *)validSymbols {
    return @[@"circle", @"triangle", @"square"];
}

+ (NSArray *)validShades {
    return @[@"solid", @"open", @"stripes"];
}

+ (NSUInteger)maxNumbers {
    return 3;
}
//valid values for properties (end)

//for set card contents
-(NSString *)contents {
    return [NSString stringWithFormat:@"[%@:%@:%@:%d]", self.symbol, self.color, self.shade, self.number];
}

//override init
-(id)init {
    self = [super init];
    if(self) {
        self.numberOfMatchingCards = 3; //this will dictate how many cards to match
    }
    return self;
}

//matching logic setcards
-(int)match:(NSArray *)otherCards {
    
    int score = 0;
    
    if([otherCards count] == self.numberOfMatchingCards - 1) {
        
        //create array for properties
        NSMutableArray *colors = [[NSMutableArray alloc] init];
        NSMutableArray *symbols = [[NSMutableArray alloc] init];
        NSMutableArray *shades = [[NSMutableArray alloc] init];
        NSMutableArray *numbers = [[NSMutableArray alloc] init];
        
        // allocate/add properties to array created
        [colors addObject:self.color]; 
        [symbols addObject:self.symbol];
        [shades addObject:self.shade];
        [numbers addObject:@((long)self.number)]; //convert the type int to long
        
        for(id otherCard in otherCards) {
            if([otherCard isKindOfClass:[SetCard class]]) {
                SetCard *otherSetCard = (SetCard *)otherCard;
                
                if(![colors containsObject:otherSetCard.color]) {
                    [colors addObject:otherSetCard.color];
                }
                if(![symbols containsObject:otherSetCard.symbol]) {
                    [symbols addObject:otherSetCard.symbol];
                }
                if(![shades containsObject:otherSetCard.shade]) {
                    [shades addObject:otherSetCard.color];
                }
                if(![numbers containsObject:@((long)otherSetCard.number)]) {
                    [numbers addObject:@((long)otherSetCard.number)];
                }
                if(([colors count] == 1 || [colors count] == self.numberOfMatchingCards)
                   && ([symbols count] == 1 || [symbols count] == self.numberOfMatchingCards)
                   && ([shades count] == 1 || [shades count] == self.numberOfMatchingCards)
                   && ([numbers count] == 1 || [numbers count] == self.numberOfMatchingCards)) {
                    score = 4;
                }
            }
        }
    }
    return score;
}

//create set cards(based on text) and add to array as result
+(NSArray *)createCardFromText:(NSString *)text {
    
    NSString *pattern = [NSString stringWithFormat:@"(%@):(%@):(%@):(\\d+)",
                         [[SetCard validSymbols] componentsJoinedByString:@"|"], //fetch valid symbol and join it to string separated by |
                         [[SetCard validColors] componentsJoinedByString:@"|"], // . . .
                         [[SetCard validShades] componentsJoinedByString:@"|"]]; // . . . 
    
    NSError *error = NULL;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    if(error) {
        return nil;
    }
    NSArray *matches = [regular matchesInString:text options:0 range:NSMakeRange(0, [text length])];
    
    if(![matches count]) {
        return nil;
    }
    
    NSMutableArray *setCards = [[NSMutableArray alloc] init];
    
    for (NSTextCheckingResult *match in matches) {
        SetCard *setCard = [[SetCard alloc] init];
        setCard.symbol = [text substringWithRange:[match rangeAtIndex:1]];
        setCard.color = [text substringWithRange:[match rangeAtIndex:2]];
        setCard.shade = [text substringWithRange:[match rangeAtIndex:3]];
        setCard.number = [[text substringWithRange:[match rangeAtIndex:4]] intValue];
        [setCards addObject:setCard];
    }
    return setCards;

}

@end

//check long
