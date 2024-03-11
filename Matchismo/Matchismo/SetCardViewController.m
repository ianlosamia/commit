//
//  SetCardViewController.m
//  Matchismo
//
//  Created by Christian Losamia on 3/6/24.
//

#import "SetCardViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "CardMatchingGame.h"

@interface SetCardViewController()

@end

@implementation SetCardViewController

-(Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}
//override backgroundImageForCard
-(UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"setcardselected" : @"setcardunselected"];
}

//returns card representation in NSAttributedString
-(NSAttributedString *)titleForCard:(Card *)card {
    
    NSString *symbol = @"?";
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    if([card isKindOfClass:[SetCard class]]) { //to check SetCard class inherits from card
        
        SetCard *setCard = (SetCard *)card;
        //setting symbol
        if([setCard.symbol isEqualToString:@"circle"]){
            symbol = @"●";
        }
        if([setCard.symbol isEqualToString:@"triangle"]) {
            symbol = @"▲";
        }
        if([setCard.symbol isEqualToString:@"square"]) {
            symbol = @"■";
        }
        
        //set up for how many number of symbol will display
        symbol = [symbol stringByPaddingToLength:setCard.number withString:symbol startingAtIndex:0];
        
        //setting color
        if([setCard.color isEqualToString:@"black"]){  //black card
            [attributes setObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
        }
        if([setCard.color isEqualToString:@"red"]) {       //red card
            [attributes setObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
        }
        if([setCard.color isEqualToString:@"blue"]) { //blue card
            [attributes setObject:[UIColor blueColor] forKey:NSForegroundColorAttributeName];
        }
        
        //setting shade
        if([setCard.shade isEqualToString:@"solid"]) {
            [attributes setObject:@-5 forKey:NSStrokeWidthAttributeName];
        }
        if([setCard.shade isEqualToString:@"stripes"]) {
            [attributes addEntriesFromDictionary:@{
                NSStrokeWidthAttributeName: @-5,
                NSStrokeColorAttributeName:attributes[NSForegroundColorAttributeName],
                NSForegroundColorAttributeName : [attributes[NSForegroundColorAttributeName] colorWithAlphaComponent:0.5]}];
        }
        if([setCard.shade isEqualToString:@"open"]) {
            [attributes setObject:@5 forKey:NSStrokeWidthAttributeName];
        }
        
    }
    return [[NSMutableAttributedString alloc] initWithString:symbol attributes:attributes];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [super updateUI];
}

-(void)updateUI {
    [super updateUI]; //updated UI by CardVC
}

@end
