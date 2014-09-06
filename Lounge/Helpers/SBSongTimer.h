//
//  SBSongTimer.h
//  Lounge
//
//  Created by Karl Persson on 2014-09-03.
//  Copyright (c) 2014 Karl Persson. All rights reserved.
//
//  Timer updating every second
//

#import <Foundation/Foundation.h>

@interface SBSongTimer : NSObject

- (instancetype)initWithTarget:(id)target selector:(SEL)sel;

- (void)start;
- (void)stop;

@end
