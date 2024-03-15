//
//  GameSettings.m
//  Matchismo
//
//  Created by Christian Losamia on 3/13/24.
//

#import "GameSettings.h"

@implementation GameSettings

//constant declaration //declare keys for dictionary
#define GAME_SETTINGS_KEY @"Game_Settings_Key"
#define MATCHBONUS_KEY @"MatchBonus_Key"
#define MISMATCHPENALTY_KEY @"MisMatchPenalty_Key"
#define FLIPCOST_KEY @"FlipCost_Key"

//setters that access helper method
-(void)setMatchBonus:(int)matchBonus {
    [self setIntValue:matchBonus forKey:MATCHBONUS_KEY];
}
-(void)setMismatchPenalty:(int)mismatchPenalty {
    [self setIntValue:mismatchPenalty forKey:MISMATCHPENALTY_KEY];
}
-(void)setFlipCost:(int)flipCost {
    [self setIntValue:flipCost forKey:FLIPCOST_KEY];
}
//setters(end)

//getters that access helper method
-(int)matchBonus {
    return [self intValueForKey:MATCHBONUS_KEY withDefault:4];
}
-(int)mismatchPenalty {
    return [self intValueForKey:MISMATCHPENALTY_KEY withDefault:2];
}
-(int)flipCost {
    return [self intValueForKey:FLIPCOST_KEY withDefault:1];
}
//getters(end)

//helper method. create new property list if not been init yet (for setter)
-(void)setIntValue:(int)value forKey:(NSString *)key {
    NSMutableDictionary *settings = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:GAME_SETTINGS_KEY] mutableCopy];
    if(!settings) {
        settings = [[NSMutableDictionary alloc]init];
    }
    settings[key] = @(value);
    [[NSUserDefaults standardUserDefaults] setObject:settings forKey:GAME_SETTINGS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//helper method which accesses the user defaults and if no valid setting is there, returns a default value (for getters)
-(int)intValueForKey:(NSString *)key withDefault:(int)defaultValue {
    NSDictionary *settings = [[NSUserDefaults standardUserDefaults] dictionaryForKey:GAME_SETTINGS_KEY];
    if(!settings) {
        return defaultValue;
    }
    if(![[settings allKeys] containsObject:key]) {
        return defaultValue;
    }
    return [settings[key]intValue];
}


@end
