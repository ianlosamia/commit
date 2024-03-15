//
//  ScoresViewController.m
//  Matchismo
//
//  Created by Christian Losamia on 3/12/24.
//

#import "ScoresViewController.h"
#import "GameResult.h"

@interface ScoresViewController()
@property (strong, nonatomic) NSArray *scores; //scores of GameResults

@property (weak, nonatomic) IBOutlet UITextView *scoresTextView;
@property (weak, nonatomic) IBOutlet UIButton *sortByScoreButton;
@property (weak, nonatomic) IBOutlet UIButton *sortByDateButton;
@property (weak, nonatomic) IBOutlet UIButton *sortByDurationButton;

@end

@implementation ScoresViewController

//create string from result
-(NSString *)stringFromResult:(GameResult *)result {
    return [NSString stringWithFormat:@"%@: %d, (%@, %gs)\n",result.gameType, result.score, [NSDateFormatter localizedStringFromDate:result.end dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle], round(result.duration)];
}

-(void)changeScore:(GameResult *)result toColor:(UIColor *)color {
    NSRange range = [self.scoresTextView.text rangeOfString:[self stringFromResult:result]];
    [self.scoresTextView.textStorage addAttribute:NSForegroundColorAttributeName value:color range:range];
}

-(void)updateUI {
    
    //1st, create strings from all game results
    NSString *text = @"";
    //use final text to populate text view
    for(GameResult *result in self.scores) {
        text = [text stringByAppendingString:[self stringFromResult:result]];
    }
    self.scoresTextView.text = text; //output text in text view
    
    //sort game results with colorizations
    NSArray *sortedScores = [self.scores sortedArrayUsingSelector:@selector(compareScore:)];
    [self changeScore:[sortedScores firstObject] toColor:[UIColor redColor]]; //highest score marked as red
    [self changeScore:[sortedScores lastObject] toColor:[UIColor yellowColor]]; //lowest score marked as yellow
    sortedScores = [self.scores sortedArrayUsingSelector:@selector(compareDuration:)];
    [self changeScore:[sortedScores firstObject] toColor:[UIColor purpleColor]]; //shortest play marked as purple
    [self changeScore:[sortedScores lastObject] toColor:[UIColor blueColor]]; // longest play marked as blue

}

//load all current game result and update UI when view will appear
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.scores = [GameResult allGameResults];
    [self updateUI];
}

- (IBAction)sortByScore {
    self.scores = [self.scores sortedArrayUsingSelector:@selector(compareScore:)];
    [self updateUI];
}
- (IBAction)sortByDate {
    self.scores = [self.scores sortedArrayUsingSelector:@selector(compareDate:)];
    [self updateUI];
}
- (IBAction)sortByDuration {
    self.scores = [self.scores sortedArrayUsingSelector:@selector(compareDuration:)];
    [self updateUI];
}


@end
