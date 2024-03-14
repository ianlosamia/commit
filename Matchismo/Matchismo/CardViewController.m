//
//  ViewController.m
//  Matchismo
//
//  Created by Christian Losamia on 2/28/24.
//

#import "CardViewController.h"
#import "CardMatchingGame.h"

@interface CardViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *selectMode; //for segment control(2/3-match)
@end

@implementation CardViewController

-(CardMatchingGame *)game {
    
    if(!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    }
    return _game;
}

//for storing flip actions of the cards (flip history)
-(NSMutableArray *)flipHistory {
    
    if(!_flipHistory) {
        _flipHistory = [NSMutableArray array];
    }
    return _flipHistory;
}

-(Deck *)createDeck { //abstract
    return nil;
}

//restart the game
- (IBAction)dealGame:(id)sender {
    
    self.game = nil;
    self.flipHistory = nil;
    self.selectMode.enabled = YES;
    [self.selectMode setSelectedSegmentIndex: 0];
    [self updateUI];
}

//buttons
- (IBAction)touchCardButton:(UIButton *)sender {
    
    self.selectMode.enabled = NO;
    long chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

-(void)updateUI {
    //to make buttons clickable and flip cards (change background/foreground image)
    for(UIButton *cardButton in self.cardButtons) {
        
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score]; //update score
    
    if(self.game) {
        NSString *description = @"";
        
        if([self.game.lastChosenCard count]) {
            NSMutableArray *cardContents = [NSMutableArray array];
            for(Card *card in self.game.lastChosenCard) {
                [cardContents addObject:card.contents];
            }
            description = [cardContents componentsJoinedByString:@" "];
        }
        if(self.game.lastScore > 0) {
            description = [NSString stringWithFormat:@"Matched %@ for %d points.", description, self.game.lastScore];
        } else if(self.game.lastScore <0) {
            description = [NSString stringWithFormat:@"%@ don't match! %d point penalty", description, -self.game.lastScore];
        }
        self.flipDescriptionLabel.textAlignment =  NSTextAlignmentCenter;
        self.flipDescriptionLabel.text = description; //self.game.gameDisplay contains the printf in cardmatchingGame
        self.flipDescriptionLabel.alpha = 1; //1 is marked as the present action happening
        
        if (![description isEqualToString:@""] && ![[self.flipHistory lastObject] isEqualToString:description]) {
            [self.flipHistory addObject:description];
            [self setSliderRange];
        }
    }
}

//helper methods

-(NSAttributedString *)titleForCard:(Card *)card {
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:card.chosen ? card.contents : @""];
    return  title;
}

-(UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"playcardback"];
}

//changing alpha value (gameplayLabel) to gray and navigate history
- (IBAction)historySlider:(UISlider *)sender {
    
    int sliderValue;
    sliderValue = lroundf(self.historySlider.value);
    [self.historySlider setValue:sliderValue animated:NO];
    
    if ([self.flipHistory count]) {
        self.flipDescriptionLabel.alpha =
        (sliderValue + 1 < [self.flipHistory count]) ? 0.6 : 1.0;
        self.flipDescriptionLabel.text =
        [self.flipHistory objectAtIndex:sliderValue];
    }
}

-(void)setSliderRange {
    int maxValue = [self.flipHistory count] - 1;
    self.historySlider.maximumValue = maxValue;
    [self.historySlider setValue:maxValue animated:YES];
}

/* for mode: 2-card match 3-card match
- (IBAction)matchMode:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
            
        case 0:
            self.game.mode = 1;
            NSLog(@"Set to 2-Card Match Mode");
            break;
        case 1:
            self.game.mode = 2;
            NSLog(@"Set to 3-Card Match Mode");
            break;
        default:
            self.game.mode = 1;
    }
}
 */
@end
