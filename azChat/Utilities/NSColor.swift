//
//  NSColor.swift
//  azChat
//
//  Created by Alex Azarov on 11/12/2017.
//  Copyright © 2017 Alex Azarov. All rights reserved.
//

import Cocoa

public extension NSColor {
    public class func hexColor(rgbValue: Int, alpha: CGFloat = 1.0) -> NSColor {
        return NSColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green:((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0, blue:((CGFloat)(rgbValue & 0xFF))/255.0, alpha:alpha)
    }
    
}
