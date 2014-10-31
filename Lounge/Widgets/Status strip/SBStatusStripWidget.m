//
//  SBStatusStripWidget.m
//  Lounge
//
//  Created by Karl Persson on 2014-09-04.
//  Copyright (c) 2014 Karl Persson. All rights reserved.
//
//	Widget putting artist and song title right in the status bar.
//

#import "SBStatusStripWidget.h"
#import "SBMediaConnectionProtocol.h"

@interface SBStatusStripWidget ()

@property (nonatomic, strong) NSStatusItem *statusItem;

@property (nonatomic, weak) NSString *artist;
@property (nonatomic, weak) NSString *title;

@property (nonatomic) BOOL hidden;

@end


@implementation SBStatusStripWidget

#pragma mark - Initialization
- (instancetype)init
{
	if (self = [super init]) {
		// Initialize status item
		self.statusItem = nil;
		self.hidden = YES;
	}
	return self;
}

#pragma mark - Widget handling
- (void)updateWidget
{
	if (self.statusItem) {
		self.statusItem.title = [NSString stringWithFormat:@"%@ — %@", self.artist, self.title];
	}
}

#pragma mark - Media observation
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	// Only try to fetch update if the sending object conforms to the given protocol
	if ([[object class] conformsToProtocol:@protocol(SBMediaConnectionProtocol)]) {
		// Update gui for property
		id<SBMediaConnectionProtocol> connection = object;
		
		if ([keyPath isEqualTo:@"running" ]) {
			// Hide when the player isn't running
			self.hidden = !connection.running;
		}
		else if ([keyPath isEqualTo:@"artist"]) {
			self.artist = connection.artist;
		}
		else if ([keyPath isEqualTo:@"title"]) {
			self.title = connection.title;
		}
	}
}

#pragma mark - Getters and setters
- (void)setArtist:(NSString *)artist
{
	_artist = artist;
	[self updateWidget];
}

- (void)setTitle:(NSString *)title
{
	_title = title;
	[self updateWidget];
}

// Hide or show widget
- (void)setHidden:(BOOL)hidden
{
	_hidden = hidden;
	
	if (hidden && self.statusItem) {
		// Hide
		[[NSStatusBar systemStatusBar] removeStatusItem:self.statusItem];
		self.statusItem = nil;
	}
	else if (!hidden && !self.statusItem) {
		// Show
		self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	}
}

@end
