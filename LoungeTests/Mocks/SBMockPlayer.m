//
//  SBMockPlayer.m
//  Lounge
//
//  Created by Karl Persson on 2014-11-01.
//  Copyright (c) 2014 Karl Persson. All rights reserved.
//

#import "SBMockPlayer.h"

@implementation SBMockPlayer

#pragma mark - Initialization
- (instancetype)initWithDelegate:(id<SBPlayerNotificationProtocol>)delegate
{
	if (self = [super init]) {
		self.delegate = delegate;
		
		self.playerName = @"MockPlayer";
		[self clear];
	}
	return self;
}

#pragma mark - Mock functions
// Force delegate update
- (void)notifyDelegate
{
	[self.delegate playerUpdated:self];
}

// Clear playback info
- (void)clear
{
	self.running = NO;
	self.playing = NO;
	self.shuffle = NO;
	self.repeat = NO;
	self.artist = @"";
	self.album = @"";
	self.title = @"";
	self.artwork = nil;
	self.length = 0.0f;
	self.position = 0.0f;
}

#pragma mark - Playback functions
- (void)next
{
	
}

- (void)previous
{
	
}

- (void)play
{
	
}

- (void)pause
{
	
}

- (void)playpause
{
	
}

@end
