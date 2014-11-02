//
//  SBMediaHub.m
//  Lounge
//
//  Created by Karl Persson on 2014-08-31.
//  Copyright (c) 2014 Karl Persson. All rights reserved.
//
//	The media hub act as a bridging layer between media players and widgets.
//

#import "SBMediaHub.h"
#import "SBSongTimer.h"

@interface SBMediaHub ()

@property (nonatomic, readonly) NSArray *subscriptionProperties;

@property (nonatomic, strong) id<SBMediaConnectionProtocol> activePlayer;
@property (nonatomic, strong) NSMutableSet *mediaPlayers;
@property (nonatomic, strong) SBSongTimer *songTimer;

// Media connection properties
@property (nonatomic, readwrite, strong) NSString *playerName;
@property (nonatomic, readwrite) BOOL running;
@property (nonatomic, readwrite) BOOL playing;
@property (nonatomic, readwrite) BOOL shuffle;
@property (nonatomic, readwrite) BOOL repeat;
@property (nonatomic, readwrite, weak) NSString *artist;
@property (nonatomic, readwrite, weak) NSString *album;
@property (nonatomic, readwrite, weak) NSString *title;
@property (nonatomic, readwrite, weak) NSImage *artwork;
@property (nonatomic, readwrite) CGFloat length;
@property (nonatomic, readwrite) CGFloat position;

@end

@implementation SBMediaHub

#pragma mark - Initialization
- (instancetype)init
{
	if (self = [super init]) {
		self.mediaPlayers = [[NSMutableSet alloc] init];
		
		// Initialize song timer
		self.songTimer = [[SBSongTimer alloc] initWithTarget:self selector:@selector(update)];
		
		[self clear];
		[self updateAll];
	}
	return self;
}

#pragma mark - Delegate widget handling
// Subscribe widget to media properties
- (void)subscribeWidget:(id)widget
{
	// Subscribe widget to all properties
	for (NSString *prop in self.subscriptionProperties) {
		[self addObserver:widget
			   forKeyPath:prop
				  options:NSKeyValueObservingOptionInitial
				  context:NULL];
	}
}

// Unsubscribe widget from media properties
- (void)unsubscribeWidget:(id)widget
{
	for (NSString *prop in self.subscriptionProperties) {
		@try {
			[self removeObserver:widget forKeyPath:prop];
		}
		@catch (NSException *__unused exception) {}
	}
}

#pragma mark - Player handling
// Add media player to the system
- (void)addMediaPlayer:(id<SBMediaConnectionProtocol>)mediaPlayer
{
	[self.mediaPlayers addObject:mediaPlayer];
	
	// Set active
	if (!self.activePlayer) {
		self.activePlayer = mediaPlayer;
		[self updateAll];
	}
}

// Remove media player from the system
- (void)removeMediaPlayer:(id<SBMediaConnectionProtocol>)mediaPlayer
{
	[self.mediaPlayers removeObject:mediaPlayer];
	
	// Set inactive
	if (self.activePlayer == mediaPlayer) {
		self.activePlayer = nil;
	}
}

// Player updated (callback from media player)
- (void)playerUpdated:(id<SBMediaConnectionProtocol>)mediaPlayer
{
	if (!mediaPlayer.running) {
		// Terminated
		if (mediaPlayer == self.activePlayer) {
			// Active player terminated
			self.activePlayer = nil;
			[self clear];
			
			// Find next running player
			for (id<SBMediaConnectionProtocol> p in self.mediaPlayers) {
				if (p.running) {
					self.activePlayer = p;
					[self updateAll];
				}
			}
		}
	}
	else {
		// Updated
		if (mediaPlayer != self.activePlayer) {
			// New active player
			self.activePlayer = mediaPlayer;
			[self clear];
		}
		[self updateAll];
	}
}

// Clear properties
- (void)clear
{
	[self.songTimer stop];
	
	self.playerName = @"";
	self.running = NO;
	self.playing = NO;
	self.shuffle = NO;
	self.repeat = NO;
	self.artist = @"";
	self.album = @"";
	self.title = @"";
	self.length = 0.0f;
	self.position = 0.0f;
	self.artwork = nil;
}

// Update incremental properties
- (BOOL)update
{
	if (self.activePlayer && self.activePlayer.running) {
		// Update non triggering properties
		if (self.running != self.activePlayer.running) {
			self.running = self.activePlayer.running;
		}
		if (self.shuffle != self.activePlayer.shuffle) {
			self.shuffle = self.activePlayer.shuffle;
		}
		if (self.repeat != self.activePlayer.repeat) {
			self.repeat = self.activePlayer.repeat;
		}
		self.position = self.activePlayer.position;
		
		return YES;
	}
	
	// Update failed
	[self clear];
	return NO;
}

// Update all properties
- (BOOL)updateAll {
	if ([self update]) {
		if (self.playing != self.activePlayer.playing) {
			self.playing = self.activePlayer.playing;
		}
		if (self.length != self.activePlayer.length) {
			self.length = self.activePlayer.length;
		}
		if (![self.playerName isEqualToString:self.activePlayer.playerName]) {
			self.playerName = self.activePlayer.playerName;
		}
		if (![self.artist isEqualToString:self.activePlayer.artist]) {
			self.artist = self.activePlayer.artist;
		}
		if (![self.album isEqualToString:self.activePlayer.album]) {
			self.album = self.activePlayer.album;
		}
		if (![self.title isEqualToString:self.activePlayer.title]) {
			self.title = self.activePlayer.title;
		}
		[self updateArtwork];
		
		return YES;
	}
	return NO;
}

// Update artwork
- (void)updateArtwork
{
	// Run artwork update every 0.1s until image is received.
	if (!(self.artwork = self.activePlayer.artwork)) {
		[self performSelector:@selector(updateArtwork) withObject:nil afterDelay:0.1f];
	}
}

#pragma mark - Getters and setters
// Playing - Overloaded to handle timer
- (void)setPlaying:(BOOL)playing
{
	_playing = playing;
	
	if (playing) {
		[self.songTimer start];
	}
	else [self.songTimer stop];
}

// Get all properties related to widget subscription
- (NSArray *)subscriptionProperties
{
	return @[@"playerName", @"running", @"playing", @"shuffle", @"repeat", @"artist", @"album", @"title", @"artwork", @"length", @"position"];
}

#pragma mark - Media player interaction
// Controls
- (void)next
{
	if (self.activePlayer) {
		[self.activePlayer next];
	}
}

- (void)previous
{
	if (self.activePlayer) {
		[self.activePlayer previous];
	}
}

- (void)play
{
	if (self.activePlayer) {
		[self.activePlayer play];
	}
}

- (void)pause
{
	if (self.activePlayer) {
		[self.activePlayer pause];
	}
}

- (void)playpause
{
	if (self.activePlayer) {
		[self.activePlayer playpause];
	}
}

@end
