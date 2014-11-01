//
//  SBMockWidget.h
//  Lounge
//
//  Created by Karl Persson on 2014-11-01.
//  Copyright (c) 2014 Karl Persson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBMockWidget : NSObject

@property (nonatomic) id KVOObject;

@property (nonatomic, weak) NSString *playerName;
@property (nonatomic) BOOL running;
@property (nonatomic) BOOL playing;
@property (nonatomic) BOOL shuffle;
@property (nonatomic) BOOL repeat;
@property (nonatomic, weak) NSString *artist;
@property (nonatomic, weak) NSString *album;
@property (nonatomic, weak) NSString *title;
@property (nonatomic, weak) NSImage *artwork;
@property (nonatomic) CGFloat length;
@property (nonatomic) CGFloat position;

@end
