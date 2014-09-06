//
//  SBPlayerNotificationProtocol.h
//  Lounge
//
//  Created by Karl Persson on 2014-09-03.
//  Copyright (c) 2014 Karl Persson. All rights reserved.
//
//  Protocol allowing media player to notify delegate about an update
//

#import <Foundation/Foundation.h>

@protocol SBPlayerNotificationProtocol <NSObject>

// Notify delegate about a media player update
- (void)playerUpdated:(id<SBMediaConnectionProtocol>)mediaPlayer;

@end
