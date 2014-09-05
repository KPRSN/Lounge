//
//  SBSpotifyConnection.m
//  Spotibar
//
//  Created by Karl Persson on 2014-08-31.
//  Copyright (c) 2014 Karl Persson. All rights reserved.
//
//	Class handling the spotify connection
//

#import "SBSpotifyConnection.h"
#import "Spotify.h"
#import "SBMediaHub.h"

@interface SBSpotifyConnection ()

@property (nonatomic, strong) SpotifyApplication *spotify;
@property (nonatomic) BOOL terminated;

@end

@implementation SBSpotifyConnection

#pragma mark - Initialization
- (instancetype)initWithDelegate:(id<SBPlayerNotificationProtocol>)delegate
{
    if (self = [self init]) {
        self.delegate = delegate;
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        // Connect to spotify
        self.spotify = [SBApplication applicationWithBundleIdentifier:@"com.spotify.client"];
        self.terminated = !self.spotify.isRunning;
        
        // Subscribe to player updates
        [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                            selector:@selector(playerStateChanged:)
                                                                name:self.notificationName
                                                              object:nil];

    }
    return self;
}

// Player state update triggered by the notification center
- (void)playerStateChanged:(NSNotification *)notification
{
    // Check if application is terminating, starting or just updating
    if (notification.userInfo.count == 1) {
        self.terminated = YES;
    }
    else self.terminated = NO;
    
    // Notify delegate
    [self.delegate playerUpdated:self];
}

#pragma mark - Getters and setters
// Player notification center name
- (NSString *)notificationName
{
    return [[self bundleIdentifier] stringByAppendingString:@".PlaybackStateChanged"];
}

// Player bundle identifier
- (NSString *)bundleIdentifier
{
    return @"com.spotify.client";
}

#pragma mark - Player functions
- (void)next
{
    [self.spotify nextTrack];
}

- (void)previous
{
    [self.spotify previousTrack];
}

- (void)play
{
    [self.spotify play];
}

- (void)pause
{
    [self.spotify pause];
}

- (void)playpause
{
    [self.spotify playpause];
}

#pragma mark - Player getters
- (NSString *)playerName
{
    return @"Spotify";
}

- (BOOL)running
{
    return (self.spotify.isRunning && !self.terminated);
}

- (BOOL)playing
{
    if (self.spotify.playerState == SpotifyEPlSPlaying) {
        return YES;
    }
    return NO;
}

- (BOOL)shuffle
{
    return self.spotify.shuffling;
}

- (BOOL)repeat
{
    return self.spotify.repeating;
}

- (NSString *)artist
{
    return self.spotify.currentTrack.artist;
}

- (NSString *)album
{
    return self.spotify.currentTrack.album;
}

- (NSString *)title
{
    return self.spotify.currentTrack.name;
}

- (NSImage *)artwork
{
    return self.spotify.currentTrack.artwork;
}

- (CGFloat)length
{
    return self.spotify.currentTrack.duration;
}

- (CGFloat)position
{
    return self.spotify.playerPosition;
}

@end
