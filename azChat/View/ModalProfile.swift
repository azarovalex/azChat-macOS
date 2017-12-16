//
//  ModalProfile.swift
//  azChat
//
//  Created by Alex Azarov on 16/12/2017.
//  Copyright © 2017 Alex Azarov. All rights reserved.
//

import Cocoa

class ModalProfile: NSView {

    @IBOutlet weak var view: NSView!
    @IBOutlet weak var userNameTxt: NSTextField!
    @IBOutlet weak var emailTxt: NSTextField!
    @IBOutlet weak var profileImg: NSImageView!
    @IBOutlet weak var logoutBtn: NSButton!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        Bundle.main.loadNibNamed(NSNib.Name(rawValue: "ModalProfile"), owner: self, topLevelObjects: nil)
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
        
        profileImg.wantsLayer = true
        profileImg.layer?.cornerRadius = 10
        profileImg.layer?.borderWidth = 3
        profileImg.layer?.borderColor = NSColor.gray.cgColor
        profileImg.image = NSImage(named: NSImage.Name(rawValue: UserDataService.instance.avatarName))
        // TODO: Add avatar background color
        
        logoutBtn.wantsLayer = true
        logoutBtn.layer?.backgroundColor = chatGreen.cgColor
        logoutBtn.layer?.cornerRadius = 7
        logoutBtn.styleButtonText(button: logoutBtn, buttonName: "Log out", fontColor: .white, alignment: .center, font: AVENIR_REGULAR, size: 13.0)
        
    }
    
    @IBAction func logoutBtnClicked(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_CLOSE_MODAL, object: nil)
        NotificationCenter.default.post(name: NOTIF_DATA_CHANGED, object: nil)
    }
    @IBAction func closeModalClicked(_ sender: Any) {
        NotificationCenter.default.post(name: NOTIF_CLOSE_MODAL, object: nil)
    }
}
