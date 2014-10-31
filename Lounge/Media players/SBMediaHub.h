//
//  SBMediaHub.h
//  Lounge
//
//  Created by Karl Persson on 2014-08-31.
//  Copyright (c) 2014 Karl Persson. All rights reserved.
//
//	The media hub act as a bridging layer between media players and widgets.
//

#import <Foundation/Foundation.h>
#import "SBMediaConnectionProtocol.h"
#import "SBPlayerNotificationProtocol.h"

@interface SBMediaHub : NSObject<SBMediaConnectionProtocol, SBPlayerNotificationProtocol>

// Media player getters
@property (nonatomic, strong, readonly) id<SBMediaConnectionProtocol> activePlayer;

// Add and remove media players
- (void)addMediaPlayer:(id<SBMediaConnectionProtocol>)mediaPlayer;
- (void)removeMediaPlayer:(id<SBMediaConnectionProtocol>)mediaPlayer;

// Widget subscription
- (void)subscribeWidget:(id)widget;
- (void)unsubscribeWidget:(id)widget;

@end
