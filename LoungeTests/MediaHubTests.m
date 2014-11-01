//
//  MediaHubTests.m
//  Lounge
//
//  Created by Karl Persson on 2014-11-01.
//  Copyright (c) 2014 Karl Persson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "SBMockWidget.h"
#import "SBMockPlayer.h"
#import "SBMediaHub.h"

@interface MediaHubTests : XCTestCase

@property (nonatomic, strong) SBMediaHub *mediaHub;
@property (nonatomic, strong) SBMockWidget *widget;

@end

@implementation MediaHubTests

- (void)setUp
{
    [super setUp];
	
	// Initialize media hub and mock widget
	self.mediaHub = [[SBMediaHub alloc] init];
	self.widget = [[SBMockWidget alloc] init];
	[self.mediaHub subscribeWidget:self.widget];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Tests
// Test playback values without any players
- (void)testNoPlayers
{
	// Test playback values
	XCTAssertEqualObjects(self.widget.playerName, @"");
	XCTAssertFalse(self.widget.running);
	XCTAssertFalse(self.widget.playing);
	XCTAssertFalse(self.widget.shuffle);
	XCTAssertFalse(self.widget.repeat);
	XCTAssertEqualObjects(self.widget.artist, @"");
	XCTAssertEqualObjects(self.widget.album, @"");
	XCTAssertEqualObjects(self.widget.title, @"");
	XCTAssertNil(self.widget.artwork);
	XCTAssert((int)self.widget.length == 0);
	XCTAssert((int)self.widget.position == 0);
	
	// Test media hub active player
	XCTAssertNil(self.mediaHub.activePlayer);
}

// Test playback values with all players terminated
- (void)testTerminatedPlayers
{
	SBMockPlayer *player = [[SBMockPlayer alloc] initWithDelegate:self.mediaHub];
	[self.mediaHub addMediaPlayer:player];
	
	// Set player info
	player.playerName = @"Player";
	NSImage *artwork = [[NSImage alloc] init];
	player.running = YES;
	player.playing = YES;
	player.shuffle = YES;
	player.repeat = YES;
	player.artist = @"Artist";
	player.album = @"Album";
	player.title = @"Title";
	player.artwork = artwork;
	player.length = 100.0f;
	player.position = 100.0f;
	[player notifyDelegate];
	
	// Clear player info
	[player clear];
	
	// Test playback values
	XCTAssertEqualObjects(self.widget.playerName, @"Player");
	XCTAssertFalse(self.widget.running);
	XCTAssertFalse(self.widget.playing);
	XCTAssertFalse(self.widget.shuffle);
	XCTAssertFalse(self.widget.repeat);
	XCTAssertEqualObjects(self.widget.artist, @"");
	XCTAssertEqualObjects(self.widget.album, @"");
	XCTAssertEqualObjects(self.widget.title, @"");
	XCTAssertNil(self.widget.artwork);
	XCTAssert((int)self.widget.length == 0);
	XCTAssert((int)self.widget.position == 0);
	
	// Test media hub active player
	XCTAssertNil(self.mediaHub.activePlayer);
}

// Test playback values with updated player
- (void)testUpdatedPlayer
{
	SBMockPlayer *player = [[SBMockPlayer alloc] initWithDelegate:self.mediaHub];
	[self.mediaHub addMediaPlayer:player];
	
	// Set player info
	player.playerName = @"Player";
	NSImage *artwork = [[NSImage alloc] init];
	player.running = YES;
	player.playing = YES;
	player.shuffle = YES;
	player.repeat = YES;
	player.artist = @"Artist";
	player.album = @"Album";
	player.title = @"Title";
	player.artwork = artwork;
	player.length = 100.0f;
	player.position = 100.0f;
	[player notifyDelegate];
	
	// Test playback values
	XCTAssertEqualObjects(self.widget.playerName, @"Player");
	XCTAssert(self.widget.running);
	XCTAssert(self.widget.playing);
	XCTAssert(self.widget.shuffle);
	XCTAssert(self.widget.repeat);
	XCTAssertEqualObjects(self.widget.artist, @"Artist");
	XCTAssertEqualObjects(self.widget.album, @"Album");
	XCTAssertEqualObjects(self.widget.title, @"Title");
	XCTAssertEqual(artwork, self.widget.artwork);
	XCTAssert((int)self.widget.length == 100);
	XCTAssert((int)self.widget.position == 100);
	
	// Test media hub active player
	XCTAssertEqual(player, self.mediaHub.activePlayer);
}

// Test updated playback values from new active player
- (void)testNewActivePlayer
{
	// Add media players
	SBMockPlayer *p1 = [[SBMockPlayer alloc] initWithDelegate:self.mediaHub];
	SBMockPlayer *p2 = [[SBMockPlayer alloc] initWithDelegate:self.mediaHub];
	[self.mediaHub addMediaPlayer:p1];
	[self.mediaHub addMediaPlayer:p2];
	
	// Set player1 info
	p1.playerName = @"P1";
	p1.running = YES;
	[p1 notifyDelegate];
	
	// Set player2 info
	p2.playerName = @"P2";
	p2.running = YES;
	[p2 notifyDelegate];
	
	// Test active player (media hub and widget)
	XCTAssertEqual(p2, self.mediaHub.activePlayer);
	XCTAssertEqualObjects(@"P2", self.widget.playerName);
}

// Test terminating active player
- (void)testTerminatedActivePlayer
{
	// Add media players
	SBMockPlayer *p1 = [[SBMockPlayer alloc] initWithDelegate:self.mediaHub];
	SBMockPlayer *p2 = [[SBMockPlayer alloc] initWithDelegate:self.mediaHub];
	[self.mediaHub addMediaPlayer:p1];
	[self.mediaHub addMediaPlayer:p2];
	
	// Set player1 info
	p1.playerName = @"P1";
	p1.running = YES;
	[p1 notifyDelegate];
	
	// Set player2 info
	p2.playerName = @"P2";
	p2.running = YES;
	[p2 notifyDelegate];
	// Terminate player2
	p2.running = NO;
	[p2 notifyDelegate];
	
	// Test active player (media hub and widget)
	XCTAssertEqual(p1, self.mediaHub.activePlayer);
	XCTAssertEqualObjects(@"P1", self.widget.playerName);
}

// Test terminating inactive player
- (void)testTerminatedInactivePlayer
{
	// Add media players
	SBMockPlayer *p1 = [[SBMockPlayer alloc] initWithDelegate:self.mediaHub];
	SBMockPlayer *p2 = [[SBMockPlayer alloc] initWithDelegate:self.mediaHub];
	[self.mediaHub addMediaPlayer:p1];
	[self.mediaHub addMediaPlayer:p2];
	
	// Set player1 info
	p1.playerName = @"P1";
	p1.running = YES;
	[p1 notifyDelegate];
	
	// Set player2 info
	p2.playerName = @"P2";
	p2.running = YES;
	[p2 notifyDelegate];
	
	// Terminate player1 (inactive)
	p1.running = NO;
	[p1 notifyDelegate];
	
	// Test active player (media hub and widget)
	XCTAssertEqual(p2, self.mediaHub.activePlayer);
	XCTAssertEqualObjects(@"P2", self.widget.playerName);
}

@end


