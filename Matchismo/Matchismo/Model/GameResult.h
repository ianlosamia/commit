//
//  Score.h
//  Matchismo
//
//  Created by Christian Losamia on 3/12/24.
//

#ifndef Score_h
#define Score_h

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

+(NSArray *)allGameResults; // will gold all the properties (all game results)

//properties
@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;
@property (strong, nonatomic) NSString *gameType; //set card or playing card

-(NSComparisonResult)compareScore:(GameResult *)result;
-(NSComparisonResult)compareDuration:(GameResult *)result;
-(NSComparisonResult)compareDate:(GameResult *)result;

@end

#endif /* Score_h */
