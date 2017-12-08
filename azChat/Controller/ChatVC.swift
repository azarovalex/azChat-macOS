//
//  ChatVC.swift
//  azChat
//
//  Created by Alex Azarov on 09/12/2017.
//  Copyright © 2017 Alex Azarov. All rights reserved.
//

import Cocoa

class ChatVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = CGColor.white
    }
    
}
