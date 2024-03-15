//
//  GameSettings.h
//  Matchismo
//
//  Created by Christian Losamia on 3/13/24.
//

#ifndef GameSettings_h
#define GameSettings_h

#import <Foundation/Foundation.h>

@interface GameSettings : NSObject

@property (nonatomic) int matchBonus;
@property (nonatomic) int mismatchPenalty;
@property (nonatomic) int flipCost;

@end

#endif /* GameSettings_h */
