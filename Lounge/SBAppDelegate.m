//
//  SBAppDelegate.m
//  Lounge
//
//  Created by Karl Persson on 2014-08-31.
//  Copyright (c) 2014 Karl Persson. All rights reserved.
//

#import "SBAppDelegate.h"
#import "SBMediaHub.h"
#import "SBMediaConnectionProtocol.h"
#import "SBPlayerDummy.h"
#import "SBStatusStripWidget.h"

#import "SBSpotifyConnection.h"

@interface SBAppDelegate ()

@property (nonatomic, strong) SBMediaHub *mediaHub;
@property (nonatomic, strong) SBPlayerDummy *playerDummy;
@property (nonatomic, strong) SBStatusStripWidget *statusStrip;

@end

@implementation SBAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    // Initialize media player hub
    self.mediaHub = [[SBMediaHub alloc] init];
	// Subscribe to media players
	[self.mediaHub addMediaPlayer:[[SBSpotifyConnection alloc] initWithDelegate:self.mediaHub]];
    
    // Create player dummy window
    self.playerDummy = [[SBPlayerDummy alloc] initWithWindowNibName:@"SBPlayerDummy"];
    [self.playerDummy showWindow:self];
    [self.mediaHub subscribeWidget:self.playerDummy];
	
	// Create status strip
	self.statusStrip = [[SBStatusStripWidget alloc] init];
	[self.mediaHub subscribeWidget:self.statusStrip];
}

@end
