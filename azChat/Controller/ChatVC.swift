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
        
    }
    
    @objc func dataDidChange(_ nofif: Notification) {
        if AuthService.instance.isLoggedIn {
            
        } else {
            
        }
    }
    
}
