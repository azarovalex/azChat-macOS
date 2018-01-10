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
    var channel: Channel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    } 
    
    override func viewWillAppear() {
        setUpView()
    }
    
    func updateWithChannel(channel: Channel) {
        typingUsersLbl.stringValue = ""
        
        self.channel = channel
        let channelName = channel.channelTitle ?? ""
        let channelDesc = channel.channelDescription ?? ""
        
        channelDescription.stringValue = channelDesc
        channelTitle.stringValue = "#\(channelName)"
        getChats()
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
    
    func getChats() {
        guard let channelId = channel?.id else { return }
        MessageSerivce.instance.findAllMessagesForChat(channelId: channelId) { (success) in
            self.tableView.reloadData()
        }
    }
    
    @IBAction func sendMessageBtnClicked(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = channel?.id else { return }
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


extension ChatVC: NSTableViewDelegate, NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return MessageSerivce.instance.messages.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "chatCell"), owner: nil) as? ChatCell {
            let chat = MessageSerivce.instance.messages[row]
            cell.configureCell(chat: chat)
            return cell
        }
        return NSTableCellView()
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 100.0
    }
}
