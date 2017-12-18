//
//  ModalCreateAccount.swift
//  azChat
//
//  Created by Alex Azarov on 12/12/2017.
//  Copyright © 2017 Alex Azarov. All rights reserved.
//

import Cocoa

class ModalCreateAccount: NSView, NSPopoverDelegate {

    // Outlets
    @IBOutlet weak var view: NSView!
    @IBOutlet weak var nameTxt: NSTextField!
    @IBOutlet weak var emailTxt: NSTextField!
    @IBOutlet weak var passwordTxt: NSSecureTextField!
    @IBOutlet weak var profileImg: NSImageView!
    @IBOutlet weak var createAccountBtn: NSButton!
    @IBOutlet weak var chooseImgBtn: NSButton!
    @IBOutlet weak var progressSpinner: NSProgressIndicator!
    @IBOutlet weak var stackView: NSStackView!
    @IBOutlet weak var colorWell: NSColorWell!
    
    // Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    let popover = NSPopover()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        Bundle.main.loadNibNamed(NSNib.Name(rawValue: "ModalCreateAccount"), owner: self, topLevelObjects: nil)
        self.addSubview(self.view)
        popover.delegate = self
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        setUpView()
    }
    
    @IBAction func chooseImgBtnClicked(_ sender: Any) {
        popover.contentViewController = AvatarPickerVC(nibName: NSNib.Name(rawValue: "AvatarPickerVC"), bundle: nil)
        popover.show(relativeTo: chooseImgBtn.bounds, of: chooseImgBtn, preferredEdge: .minX)
        popover.behavior = .transient
        
    }
    
    func popoverDidClose(_ notification: Notification) {
        if UserDataService.instance.avatarName != "" {
            profileImg.image = NSImage(named: NSImage.Name(rawValue: UserDataService.instance.avatarName))
            avatarName = UserDataService.instance.avatarName
        }
    }
    @IBAction func colorPicked(_ sender: Any) {
        profileImg.layer?.backgroundColor = colorWell.color.cgColor
        let color = colorWell.color.cgColor
        guard let colorArray = color.components?.description else {
            return
        }
        avatarColor = colorArray
        print(colorArray)
    }
    
    @IBAction func createAccountBtnClicked(_ sender: Any) {
        progressSpinner.isHidden = false
        progressSpinner.startAnimation(nil)
        stackView.alphaValue = 0.4
        createAccountBtn.isEnabled = false
        AuthService.instance.registerUser(email: emailTxt.stringValue, password: passwordTxt.stringValue) { (success) in
            if success {
                AuthService.instance.loginUser(email: self.emailTxt.stringValue, password: self.passwordTxt.stringValue, completion: { (success) in
                    AuthService.instance.createUser(name: self.nameTxt.stringValue, email:  self.emailTxt.stringValue, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                        self.progressSpinner.stopAnimation(nil)
                        
                        NotificationCenter.default.post(name: NOTIF_CLOSE_MODAL, object: nil)
                        NotificationCenter.default.post(name: NOTIF_DATA_CHANGED, object: nil)
                    })
                })
            }
        }
        
    }
    
    @IBAction func closeModalClicked(_ sender: Any) {
        NotificationCenter.default.post(name: NOTIF_CLOSE_MODAL, object: nil)
    }
    
    func setUpView() {
        self.view.frame = NSRect(x: 0, y: 0, width: 475, height: 300)
        view.wantsLayer = true
        view.layer?.backgroundColor = CGColor.white
        view.layer?.cornerRadius = 7
        
        profileImg.wantsLayer = true
        profileImg.layer?.cornerRadius = 10
        profileImg.layer?.borderColor = NSColor.systemGray.cgColor
        profileImg.layer?.borderWidth = 5
        
        createAccountBtn.wantsLayer = true
        chooseImgBtn.wantsLayer = true
        createAccountBtn.layer?.backgroundColor = chatGreen.cgColor
        chooseImgBtn.layer?.backgroundColor = chatGreen.cgColor
        createAccountBtn.layer?.cornerRadius = 5
        chooseImgBtn.layer?.cornerRadius = 5
        
        createAccountBtn.styleButtonText(button: createAccountBtn, buttonName: "Create Account", fontColor:  .white, alignment: .center, font: AVENIR_REGULAR, size: 13)
        chooseImgBtn.styleButtonText(button: chooseImgBtn, buttonName: "Choose Avatar", fontColor: .white, alignment: .center, font: AVENIR_REGULAR, size: 13)
        
        passwordTxt.focusRingType = .none
    }
}
