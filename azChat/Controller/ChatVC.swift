//
//  ChatVC.swift
//  azChat
//
//  Created by Alex Azarov on 09/12/2017.
//  Copyright © 2017 Alex Azarov. All rights reserved.
//

import Cocoa

class ChatVC: NSViewController {

    // Outlets
    @IBOutlet weak var channelTitle: NSTextField!
    @IBOutlet weak var channelDescription: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var typingUsersLbl: NSTextField!
    @IBOutlet weak var messageOutlineView: NSView!
    @IBOutlet weak var messageText: NSTextField!
    @IBOutlet weak var sendMessageBtn: NSButton!
    
    let user = UserDataService.instance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    } 
    
    override func viewWillAppear() {
        setUpView()
    }
    
    func setUpView() {
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.dataDidChange(_:)), name: NOTIF_DATA_CHANGED, object: nil)
        
        view.wantsLayer = true
        view.layer?.backgroundColor = CGColor.white
        
        messageOutlineView.wantsLayer = true
        messageOutlineView.layer?.backgroundColor = CGColor.white
        messageOutlineView.layer?.borderColor = NSColor.controlColor.cgColor
        messageOutlineView.layer?.borderWidth = 2
        messageOutlineView.layer?.cornerRadius = 5
        
        sendMessageBtn.styleButtonText(button: sendMessageBtn, buttonName: "Send", fontColor: .systemGray, alignment: .center, font: AVENIR_REGULAR, size: 13.0)
    }
    
    @IBAction func sendMessageBtnClicked(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let channelId = "592cd40e39179c0023f3531f"
            SocketService.instance.addMessage(messageBody: messageText.stringValue, userId: user.id, channelId: channelId, completion: { (success) in
                if success {
                    self.messageText.stringValue = ""
                }
            })
        } else {
            let loginDict: [String: ModalType] = [USER_INFO_MODAL: ModalType.logIn]
            NotificationCenter.default.post(name: NOTIF_PRESENT_MODAL, object: nil, userInfo: loginDict)
        }
    }
    
    @objc func dataDidChange(_ nofif: Notification) {
        if AuthService.instance.isLoggedIn {
            channelTitle.stringValue = "#General"
            channelDescription.stringValue = "This is were the chat happens."
        } else {
            channelTitle.stringValue = "Please Log In"
            channelDescription.stringValue = ""
        }
    }
    
}
