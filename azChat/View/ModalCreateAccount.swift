//
//  ModalCreateAccount.swift
//  azChat
//
//  Created by Alex Azarov on 12/12/2017.
//  Copyright © 2017 Alex Azarov. All rights reserved.
//

import Cocoa

class ModalCreateAccount: NSView {

    // Outlets
    @IBOutlet weak var view: NSView!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        Bundle.main.loadNibNamed(NSNib.Name(rawValue: "ModalCreateAccount"), owner: self, topLevelObjects: nil)
        self.addSubview(self.view)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        setUpView()
    }
    
    func setUpView() {
        self.view.frame = NSRect(x: 0, y: 0, width: 475, height: 300)
        view.wantsLayer = true
        view.layer?.backgroundColor = CGColor.white
        view.layer?.cornerRadius = 7
        
    }
    
}
