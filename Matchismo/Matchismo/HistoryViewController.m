//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Christian Losamia on 3/7/24.
//

#import "HistoryViewController.h"

@interface HistoryViewController()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;
@end

@implementation HistoryViewController

//setter
-(void)setHistory:(NSArray *)history {
    _history = history;
    
    if(self.view.window) {//When the array gets set and is on screen update ui
        [self updateUI];
    }
}

//update interface
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

-(void)updateUI {
    
    if([[self.history firstObject] isKindOfClass:[NSAttributedString class]]) {
        //create output string if the the content is attributed string. (set card)
        NSMutableAttributedString *historyText = [[NSMutableAttributedString alloc]init];
        
        int i = 1;
        for(NSAttributedString *line in self.history) {
            [historyText appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%2d: ", i++]]];
            [historyText appendAttributedString:line];
            [historyText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n"]];
        }
        UIFont *font = [self.historyTextView.textStorage attribute:NSFontAttributeName atIndex:0 effectiveRange:NULL];
        [historyText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, historyText.length)];
        self.historyTextView.attributedText = historyText;
        
    } else {
        //else, create output string if the contetnt is normal string(playing card)
        NSString *historyText = @"";
        int i = 1;
        for(NSString *line in self.history) {
            historyText = [NSString stringWithFormat:@"%@%2d: %@\n\n", historyText, i++, line];
        }
        self.historyTextView.text = historyText;
    }
}

@end
