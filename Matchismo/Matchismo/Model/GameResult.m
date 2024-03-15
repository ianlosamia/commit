//
//  Score.m
//  Matchismo
//
//  Created by Christian Losamia on 3/12/24.
//

#import "GameResult.h"

@interface GameResult()

//make start&end writable privately
@property (readwrite,nonatomic) NSDate *start;
@property (readwrite,nonatomic) NSDate *end;

@end

@implementation GameResult

//constant declaration //declare keys for dictionary
#define ALL_RESULTS_KEY @"GameResult_All"
#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"
#define GAME_KEY @"Game"

//generating on fly
-(NSTimeInterval)duration {
    return [self.end timeIntervalSinceDate:self.start];
}

//setter. whenever score changes, save result to user default(synchronize)
-(void)setScore:(int)score {
    _score = score;
    self.end = [NSDate date];
    [self synchronize];
}

//this is just another dictionary
-(id)asPropertyList {
    return @{START_KEY:self.start, END_KEY:self.end, SCORE_KEY:@(self.score), GAME_KEY:self.gameType};
}

//saving (user defaults)
-(void)synchronize {
    //results store to dictionary which use start time/date as key
    NSMutableDictionary *gameResultsFromUserDefaults =[[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
    if(!gameResultsFromUserDefaults) {
        gameResultsFromUserDefaults = [[NSMutableDictionary alloc] init];
    }
    gameResultsFromUserDefaults [[self.start description]] = [self asPropertyList];
    [[NSUserDefaults standardUserDefaults] setObject:gameResultsFromUserDefaults forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//when we generate new result, timer will start running
-(id)init {
    self = [super init];
    if(self) {
        _start = [NSDate date];
        _end = _start;
    }
    return self;
}

//take every entry of property list and fills the result property
-(id)initFromPropertyList:(id)plist {
    self = [self init];
    if(self) {
        if([plist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = (NSDictionary *)plist;
            _start = resultDictionary[START_KEY];
            _end = resultDictionary[END_KEY];
            _score = [resultDictionary[SCORE_KEY] intValue];
            _gameType = resultDictionary[GAME_KEY];
            if(!_start || !_end) {
                self = nil;
            }
        }
    }
    return self;
}

//for reading back all game result.
+(NSArray *)allGameResults {
    NSMutableArray *allGameResults = [[NSMutableArray alloc] init];
    
    //create each single result, based on the stored property list/dictionarty ^^
    for(id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]) {
        GameResult *result = [[GameResult alloc] initFromPropertyList:plist];
        [allGameResults addObject:result];
    }
    return  allGameResults;
}

//for sorting. helper method compare appropriate properties
-(NSComparisonResult)compareScore:(GameResult *)result {
    return [@(result.score) compare:@(self.score)];
}
-(NSComparisonResult)compareDuration:(GameResult *)result {
    return  [@(self.duration) compare:@(result.duration)];
}
-(NSComparisonResult)compareDate:(GameResult *)result {
    return [result.end compare:self.end];
}




@end
