//
//  SBPlayerDummy.m
//  Spotibar
//
//  Created by Karl Persson on 2014-09-01.
//  Copyright (c) 2014 Karl Persson. All rights reserved.
//
//	Widget used for testing purpouses.
//

#import "SBPlayerDummy.h"
#import "SBMediaConnectionProtocol.h"
#import "SBTimeFormatter.h"

@interface SBPlayerDummy ()

@property (weak) IBOutlet NSTextField *titleArtistLabel;
@property (weak) IBOutlet NSTextField *albumLabel;
@property (weak) IBOutlet NSTextField *positionLabel;
@property (weak) IBOutlet NSTextField *lengthLabel;
@property (weak) IBOutlet NSTextField *repeatLabel;
@property (weak) IBOutlet NSTextField *shuffleLabel;
@property (weak) IBOutlet NSImageView *artworkView;

@end

@implementation SBPlayerDummy

#pragma mark - Initialization
- (instancetype)initWithWindowNibName:(NSString *)windowNibName
{
    if (self = [super initWithWindowNibName:windowNibName]) {
        // Init
    }
    return self;
}

#pragma mark - GUI
- (void)setRepeatActive:(BOOL)active
{
    if (active) {
        self.repeatLabel.textColor = [NSColor blackColor];
    }
    else {
        self.repeatLabel.textColor = [NSColor lightGrayColor];
    }
}

- (void)setShuffleActive:(BOOL)active
{
    if (active) {
        self.shuffleLabel.textColor = [NSColor blackColor];
    }
    else {
        self.shuffleLabel.textColor = [NSColor lightGrayColor];
    }
}

#pragma mark - Media observation
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // Only try to fetch update if the sending object conforms to the given protocol
    if ([[object class] conformsToProtocol:@protocol(SBMediaConnectionProtocol)]) {
        // Update gui for property
        id<SBMediaConnectionProtocol> connection = object;
        
        if ([keyPath isEqualToString:@"playerName"]) {
            
        }
        else if ([keyPath isEqualTo:@"running"]) {
            
        }
        else if ([keyPath isEqualTo:@"playing"]) {
            
        }
        else if ([keyPath isEqualTo:@"shuffle"]) {
            [self setShuffleActive:connection.shuffle];
        }
        else if ([keyPath isEqualTo:@"repeat"]) {
            [self setRepeatActive:connection.repeat];
        }
        else if ([keyPath isEqualTo:@"artist"]) {
            self.titleArtistLabel.stringValue = [NSString stringWithFormat:@"%@ — %@", connection.artist, connection.title];
        }
        else if ([keyPath isEqualTo:@"album"]) {
            self.albumLabel.stringValue = connection.album;
        }
        else if ([keyPath isEqualTo:@"title"]) {
            self.titleArtistLabel.stringValue = [NSString stringWithFormat:@"%@ — %@", connection.artist, connection.title];
        }
        else if ([keyPath isEqualTo:@"artwork"]) {
            self.artworkView.image = nil;
            self.artworkView.image = connection.artwork;
        }
        else if ([keyPath isEqualTo:@"length"]) {
            self.lengthLabel.stringValue = [SBTimeFormatter timeToString:connection.length];
        }
        else if ([keyPath isEqualTo:@"position"]) {
            self.positionLabel.stringValue = [SBTimeFormatter timeToString:connection.position];
        }
        else NSLog(@"Unknown key path: %@", keyPath);
    }
}

@end
