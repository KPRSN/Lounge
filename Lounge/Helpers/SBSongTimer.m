//
//  SBSongTimer.m
//  Lounge
//
//  Created by Karl Persson on 2014-09-03.
//  Copyright (c) 2014 Karl Persson. All rights reserved.
//
//  Timer updating every second
//

#import "SBSongTimer.h"
#import "SBMediaConnectionProtocol.h"

@interface SBSongTimer ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, weak) id target;
@property (nonatomic) SEL selector;

@end


@implementation SBSongTimer

- (instancetype)initWithTarget:(id)target selector:(SEL)sel
{
    if (self = [super init]) {
        self.target = target;
        self.selector = sel;
    }
    return self;
}

- (void)start
{
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self.target
                                                    selector:self.selector
                                                    userInfo:nil
                                                     repeats:YES];
    }
}

- (void)stop
{
    [self.timer invalidate];
    self.timer = nil;
}

@end
