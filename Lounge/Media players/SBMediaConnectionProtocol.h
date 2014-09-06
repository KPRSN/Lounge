//
//  SBMediaConnectionProtocol.h
//  Lounge
//
//  Created by Karl Persson on 2014-08-31.
//  Copyright (c) 2014 Karl Persson. All rights reserved.
//
//  Protocol used for media player access
//

#import <Foundation/Foundation.h>

@class SBMediaHub;


@protocol SBMediaConnectionProtocol <NSObject>

// Player info
@property (nonatomic, readonly, strong) NSString *playerName;
@property (nonatomic, readonly) BOOL running;

// Playback
@property (nonatomic, readonly) BOOL playing;
@property (nonatomic, readonly) BOOL shuffle;
@property (nonatomic, readonly) BOOL repeat;

// Track
@property (nonatomic, readonly, weak) NSString *artist;
@property (nonatomic, readonly, weak) NSString *album;
@property (nonatomic, readonly, weak) NSString *title;
@property (nonatomic, readonly, weak) NSImage *artwork;
@property (nonatomic, readonly) CGFloat length;
@property (nonatomic, readonly) CGFloat position;

// Controls
- (void)next;
- (void)previous;
- (void)play;
- (void)pause;
- (void)playpause;

@end
