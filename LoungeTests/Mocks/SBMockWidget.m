//
//  SBMockWidget.m
//  Lounge
//
//  Created by Karl Persson on 2014-11-01.
//  Copyright (c) 2014 Karl Persson. All rights reserved.
//

#import "SBMockWidget.h"
#import "SBMediaConnectionProtocol.h"

@implementation SBMockWidget

#pragma mark - Media observation
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	self.KVOObject = object;
	
	// Only try to fetch update if the sending object conforms to the given protocol
	if ([[object class] conformsToProtocol:@protocol(SBMediaConnectionProtocol)]) {
		// Update gui for property
		id<SBMediaConnectionProtocol> connection = object;
		
		if ([keyPath isEqualToString:@"playerName"]) {
			self.playerName = connection.playerName;
		}
		else if ([keyPath isEqualTo:@"running"]) {
			self.running = connection.running;
		}
		else if ([keyPath isEqualTo:@"playing"]) {
			self.playing = connection.playing;
		}
		else if ([keyPath isEqualTo:@"shuffle"]) {
			self.shuffle = connection.shuffle;
		}
		else if ([keyPath isEqualTo:@"repeat"]) {
			self.repeat = connection.repeat;
		}
		else if ([keyPath isEqualTo:@"artist"]) {
			self.artist = connection.artist;
		}
		else if ([keyPath isEqualTo:@"album"]) {
			self.album = connection.album;
		}
		else if ([keyPath isEqualTo:@"title"]) {
			self.title = connection.title;
		}
		else if ([keyPath isEqualTo:@"artwork"]) {
			self.artwork = connection.artwork;
		}
		else if ([keyPath isEqualTo:@"length"]) {
			self.length = connection.length;
		}
		else if ([keyPath isEqualTo:@"position"]) {
			self.position = connection.position;
		}
	}
}

@end
