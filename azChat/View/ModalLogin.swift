//
//  ModalLogin.swift
//  azChat
//
//  Created by Alex Azarov on 10/12/2017.
//  Copyright © 2017 Alex Azarov. All rights reserved.
//

import Cocoa

class ModalLogin: NSView {

    // Outlets
    @IBOutlet weak var view: NSView!
    @IBOutlet weak var userNameTxt: NSTextField!
    @IBOutlet weak var passwordTxt: NSSecureTextField!
    @IBOutlet weak var loginButton: NSButton!
    @IBOutlet weak var createAccountBtn: NSButton!
    @IBOutlet weak var stackView: NSStackView!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        Bundle.main.loadNibNamed(NSNib.Name(rawValue: "ModalLogin"), owner: self, topLevelObjects: nil)
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
        
        loginButton.layer?.backgroundColor = chatGreen.cgColor
        loginButton.layer?.cornerRadius = 7
        loginButton.styleButtonText(button: loginButton, buttonName: "Login", fontColor: NSColor.darkGray, alignment: .center, font: AVENIR_REGULAR, size: 14)
        
        createAccountBtn.styleButtonText(button: createAccountBtn, buttonName: "Create Account", fontColor: chatGreen, alignment: .center, font: AVENIR_REGULAR, size: 12)
    }
    
    
    @IBAction func closeModalClicked(_ sender: Any) {
        NotificationCenter.default.post(name: NOTIF_CLOSE_MODAL, object: nil)
    }
    
    @IBAction func loginBtnClicked(_ sender: Any) {
    }
    
    @IBAction func createAccountBtnClicked(_ sender: Any) {
        let closeImmediatelyDict: [String: Bool] = [USER_INFO_REMOVE_IMMEDIATELY: true]
        NotificationCenter.default.post(name: NOTIF_CLOSE_MODAL, object: nil, userInfo: closeImmediatelyDict)
        let createAccountDict: [String: ModalType] = [USER_INFO_MODAL: ModalType.createAccount]
        NotificationCenter.default.post(name: NOTIF_PRESENT_MODAL, object: nil, userInfo:createAccountDict)
    }
}
