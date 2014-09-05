//
//  SBSpotifyConnection.h
//  Spotibar
//
//  Created by Karl Persson on 2014-08-31.
//  Copyright (c) 2014 Karl Persson. All rights reserved.
//
//	Class handling the spotify connection
//

#import <Foundation/Foundation.h>
#import "SBMediaConnectionProtocol.h"
#import "SBPlayerNotificationProtocol.h"

@interface SBSpotifyConnection : NSObject <SBMediaConnectionProtocol>

@property (nonatomic, weak) id<SBPlayerNotificationProtocol> delegate;

- (instancetype)initWithDelegate:(id<SBPlayerNotificationProtocol>)delegate;

@end
