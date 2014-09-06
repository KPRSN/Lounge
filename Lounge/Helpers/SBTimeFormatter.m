//
//  SBTimeFormatter.m
//  Lounge
//
//  Created by Karl Persson on 2014-09-03.
//  Copyright (c) 2014 Karl Persson. All rights reserved.
//
//  Helper class for making readable time strings out of floating point numbers.
//

#import "SBTimeFormatter.h"

@implementation SBTimeFormatter

// Convert time in seconds to string (HH:MM:SS)
+ (NSString *)timeToString:(CGFloat)timeInSeconds
{
    int seconds = (int)(timeInSeconds + 0.5f);
    int minutes = 0;
    int hours = 0;
    
    // Calculate minutes
    while (seconds >= 60) {
        seconds -= 60;
        minutes++;
    }
    // Calculate hours
    while (minutes >= 60) {
        minutes -= 60;
        hours++;
    }
    
    // Format string
    NSString *result;
    if (hours > 0) {
        result = [NSString stringWithFormat:@"%d:%02d:%02d", hours, minutes, seconds];
    }
    else {
        result = [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
    }
    
    return result;
}

@end
