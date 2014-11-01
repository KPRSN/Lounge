//
//  SBMockPlayer.h
//  Lounge
//
//  Created by Karl Persson on 2014-11-01.
//  Copyright (c) 2014 Karl Persson. All rights reserved.
//
//	Mock media player, for mimicking media player functionality
//	Set values and notify delegate
//

#import <Foundation/Foundation.h>
#import "SBMediaConnectionProtocol.h"
#import "SBPlayerNotificationProtocol.h"

@interface SBMockPlayer : NSObject <SBMediaConnectionProtocol>

@property (nonatomic, weak) id<SBPlayerNotificationProtocol> delegate;

- (instancetype)initWithDelegate:(id<SBPlayerNotificationProtocol>)delegate;

// Force delegate update
- (void)notifyDelegate;

// Clear player info
- (void)clear;

// Player info
@property (nonatomic, strong) NSString *playerName;
@property (nonatomic) BOOL running;

// Playback
@property (nonatomic) BOOL playing;
@property (nonatomic) BOOL shuffle;
@property (nonatomic) BOOL repeat;

// Track
@property (nonatomic, weak) NSString *artist;
@property (nonatomic, weak) NSString *album;
@property (nonatomic, weak) NSString *title;
@property (nonatomic, weak) NSImage *artwork;
@property (nonatomic) CGFloat length;
@property (nonatomic) CGFloat position;

@end
