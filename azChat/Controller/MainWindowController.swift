//
//  MainWindowController.swift
//  azChat
//
//  Created by Alex Azarov on 09/12/2017.
//  Copyright © 2017 Alex Azarov. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSWindowDelegate {

    override func windowDidLoad() {
        super.windowDidLoad()
        window?.titlebarAppearsTransparent = true
        window?.titleVisibility = .hidden
        window?.delegate = self
        window?.minSize = NSSize(width: 950, height: 600)
    }
    
    func windowWillMiniaturize(_ notification: Notification) {
        UserDataService.instance.isMinimazing = true
    }
    
    func windowDidDeminiaturize(_ notification: Notification) {
        UserDataService.instance.isMinimazing = false
    }
    
}
