//
//  ViewController.m
//  Matchismo
//
//  Created by Christian Losamia on 2/28/24.
//

#import "CardViewController.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"
#import "GameResult.h"
#import "GameSettings.h"

@interface CardViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *selectMode; //for segment control(2/3-match)

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) GameResult *gameResult;
@property (strong, nonatomic) GameSettings *gameSettings;
@end

@implementation CardViewController

//for using the property of various models (init lazily) [start]
-(GameResult *)gameResult {
    if (!_gameResult) {
        _gameResult = [[GameResult alloc] init];
    }
    _gameResult.gameType = self.gameType;
    return _gameResult;
}

-(GameSettings *)gameSettings {
    if(!_gameSettings) {
        _gameSettings = [[GameSettings alloc] init];
    }
    return _gameSettings;
}
-(CardMatchingGame *)game {
    
    if(!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    }
    //pass the settings to the game when it is init
    _game.matchBonus = self.gameSettings.matchBonus;
    _game.mismatchPenalty = self.gameSettings.mismatchPenalty;
    _game.flipCost = self.gameSettings.flipCost;
    
    return _game;
}
//for using the property of various models (init lazily) [end]

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
    self.gameResult = nil; //reset the results when new deck is dealt (deal game)
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

- (IBAction)changeModeSelector:(UISegmentedControl *)sender {
    self.game.maxMatchingCards = [[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] integerValue];
}

//changing alpha value (gameplayLabel) to gray and navigate history
- (IBAction)historySliderAction:(UISlider *)sender {
    
    long sliderValue; //originally int
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
    long maxValue = [self.flipHistory count] - 1; //origingally int
    self.historySlider.maximumValue = maxValue;
    [self.historySlider setValue:maxValue animated:YES];
}

-(void)updateUI {
    //to make buttons clickable and flip cards (change background/foreground image)
    for(UIButton *cardButton in self.cardButtons) {
        
        long cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score]; //update score
    self.gameResult.score = self.game.score; //update score of the game result when UI is updatedc(1)
    
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
            NSLog(@"%@", description);
        } else if(self.game.lastScore <0) {
            description = [NSString stringWithFormat:@"%@ don't match! %d point penalty", description, -self.game.lastScore];
            NSLog(@"%@", description);
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"show history"]) {
        if([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            [segue.destinationViewController setHistory:self.flipHistory];
        }
    }
}

//settings will be used immediately when returning to card game
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.game.matchBonus = self.gameSettings.matchBonus;
    self.game.mismatchPenalty = self.gameSettings.mismatchPenalty;
    self.game.flipCost = self.gameSettings.flipCost;
}

@end
