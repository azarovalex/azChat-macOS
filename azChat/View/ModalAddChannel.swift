//
//  ModalAddChannel.swift
//  azChat
//
//  Created by Alex Azarov on 17/12/2017.
//  Copyright © 2017 Alex Azarov. All rights reserved.
//

import Cocoa

class ModalAddChannel: NSView {
    
    @IBOutlet weak var view: NSView!
    @IBOutlet weak var channelName: NSTextField!
    @IBOutlet weak var channelDescription: NSTextField!
    @IBOutlet weak var addChannelBtn: NSButton!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        Bundle.main.loadNibNamed(NSNib.Name(rawValue: "ModalAddChannel"), owner: self, topLevelObjects: nil)
        self.addSubview(self.view)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        setUpView()
    }
    
    @IBAction func addChannelBtnClicked(_ sender: Any) {
        SocketService.instance.addChannel(channelName: channelName.stringValue, channelDescription: channelDescription.stringValue) { (success) in
            if success {
                    NotificationCenter.default.post(name: NOTIF_CLOSE_MODAL, object: nil)
            }
        }
    }
    
    func setUpView() {
        self.view.frame = NSRect(x: 0, y: 0, width: 475, height: 300)
        
        view.wantsLayer = true
        view.layer?.backgroundColor = CGColor.white
        view.layer?.cornerRadius = 7
        
        addChannelBtn.wantsLayer = true
        addChannelBtn.layer?.backgroundColor = chatGreen.cgColor
        addChannelBtn.layer?.cornerRadius = 7
        addChannelBtn.styleButtonText(button: addChannelBtn, buttonName: "Add Channel", fontColor: .white, alignment: .center, font: AVENIR_REGULAR, size: 13.0)
        
    }
    @IBAction func closeModalPressed(_ sender: Any) {
        NotificationCenter.default.post(name: NOTIF_CLOSE_MODAL, object: nil)
    }
}
