//
//  SplitView.swift
//  azChat
//
//  Created by Alex Azarov on 15/01/2018.
//  Copyright © 2018 Alex Azarov. All rights reserved.
//

import Cocoa

class SplitView: NSSplitView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override var dividerThickness: CGFloat {
        get { return 0.0 }
    }
    
}
