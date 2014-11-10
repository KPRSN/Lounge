//
//  SBStatusPlayerWidget.swift
//  Lounge
//
//  Created by Karl Persson on 2014-11-10.
//  Copyright (c) 2014 Karl Persson. All rights reserved.
//

import Cocoa

class SBStatusPlayerWidget: NSObject {
	private let statusItem: NSStatusItem = NSStatusItem();
	private var hidden: Bool = true;
	
	override init()
	{
		// Initialize here
		
		super.init();
	}
	
	// MARK: Media observation
	override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
		let connection = object as SBMediaConnectionProtocol;
		
		// Check object type
		if (object is SBMediaConnectionProtocol) {
			if (keyPath == "running") {
				
			}
			else if (keyPath == "playing") {
				
			}
			else if (keyPath == "shuffle") {
				
			}
			else if (keyPath == "repeat") {
				
			}
			else if (keyPath == "artist") {
				
			}
			else if (keyPath == "album") {
				
			}
			else if (keyPath == "title") {
				println("\(connection.title)");
			}
			else if (keyPath == "artwork") {
				
			}
			else if (keyPath == "length") {
				
			}
			else if (keyPath == "position") {
				
			}
		}
	}
}
