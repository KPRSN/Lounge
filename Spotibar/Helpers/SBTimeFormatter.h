//
//  SBTimeFormatter.h
//  Spotibar
//
//  Created by Karl Persson on 2014-09-03.
//  Copyright (c) 2014 Karl Persson. All rights reserved.
//
//  Helper class for making readable time strings out of floating point numbers.
//

#import <Foundation/Foundation.h>

@interface SBTimeFormatter : NSObject

+ (NSString *)timeToString:(CGFloat)timeInSeconds;

@end
