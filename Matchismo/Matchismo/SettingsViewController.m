//
//  SettingsViewController.m
//  Matchismo
//
//  Created by Christian Losamia on 3/13/24.
//

#import "SettingsViewController.h"
#import "GameSettings.h"

@interface SettingsViewController()
@property (weak, nonatomic) IBOutlet UILabel *matchBonusLabel;
@property (weak, nonatomic) IBOutlet UILabel *mismatchPenaltyLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipCostLabel;
@property (weak, nonatomic) IBOutlet UISlider *matchBonusSlider;
@property (weak, nonatomic) IBOutlet UISlider *mismatchPenaltySlider;
@property (weak, nonatomic) IBOutlet UISlider *flipCostSlider;

@property (strong, nonatomic) GameSettings *gameSettings;


@end

@implementation SettingsViewController

//for using the property of the game settings model (init lazily)
-(GameSettings *)gameSettings {
    if(!_gameSettings) {
        _gameSettings = [[GameSettings alloc]init];
    }
    return _gameSettings;
}

- (IBAction)matchBonusSliderAction:(UISlider *)sender {
    [self setLabel:self.matchBonusLabel forSlider:sender];
    self.gameSettings.matchBonus = floor(sender.value);
}

- (IBAction)mismatchPenaltySliderAction:(UISlider *)sender {
    [self setLabel:self.mismatchPenaltyLabel forSlider:sender];
    self.gameSettings.mismatchPenalty = floor(sender.value);
}

- (IBAction)flipCostSliderAction:(UISlider *)sender {
    [self setLabel:self.flipCostLabel forSlider:sender];
    self.gameSettings.flipCost = floor(sender.value);
}

//helper method for setters
-(void)setLabel:(UILabel *)label forSlider:(UISlider *)slider {
    int sliderValue;
    sliderValue = lround(slider.value);
    [slider setValue:sliderValue animated:NO];
    label.text = [NSString stringWithFormat:@"%d", sliderValue];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //when settingVC appear, set the slider and label according to stored settings
    self.matchBonusSlider.value = self.gameSettings.matchBonus;
    self.mismatchPenaltySlider.value = self.gameSettings.mismatchPenalty;
    self.flipCostSlider.value = self.gameSettings.flipCost;
    [self setLabel:self.matchBonusLabel forSlider:self.matchBonusSlider];
    [self setLabel:self.mismatchPenaltyLabel forSlider:self.mismatchPenaltySlider];
    [self setLabel:self.flipCostLabel forSlider:self.flipCostSlider];
}


@end
