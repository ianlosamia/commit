//
//  ViewController.h
//  Matchismo
//
//  Created by Christian Losamia on 2/28/24.
// abstract class, must implement method as described below

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardViewController : UIViewController

//protected
//for subclasses
- (Deck *)createDeck; //abstract

-(NSAttributedString *)titleForCard:(Card *)card;
-(UIImage *)backgroundImageForCard:(Card *)card;
-(void)updateUI;

@property (weak, nonatomic) IBOutlet UILabel *flipDescriptionLabel; //texts in every flip
@property (strong, nonatomic) NSMutableArray *flipHistory; // of NSStrings

@property (strong, nonatomic) NSString *gameType; //need to hold the game results

@end

