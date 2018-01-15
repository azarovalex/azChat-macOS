//
//  ChannelVC.swift
//  azChat
//
//  Created by Alex Azarov on 09/12/2017.
//  Copyright © 2017 Alex Azarov. All rights reserved.
//

import Cocoa

class ChannelVC: NSViewController {

    // Outlets
    @IBOutlet weak var usernameLbl: NSTextField!
    @IBOutlet weak var addChannelBtn: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    
    // Variables
    var selectedChannelIndex = 0
    var selectedChannel: Channel?
    var chatVC: ChatVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear() {
        setUpView()
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.dataDidChange(_:)), name: NOTIF_DATA_CHANGED, object: nil)
    }
    
    override func viewDidAppear() {
        chatVC = self.view.window?.contentViewController?.childViewControllers[0].childViewControllers[1] as? ChatVC
        SocketService.instance.getChannel { (success) in
            if success {
                self.tableView.reloadData()
                if MessageSerivce.instance.channels.count > 0 {
                    self.tableView.selectRowIndexes(IndexSet(integer: self.selectedChannelIndex), byExtendingSelection: false)
                }
            }
        }
    }
    
    func setUpView() {
        view.wantsLayer = true
        view.layer?.backgroundColor = chatPurple.cgColor
        addChannelBtn.styleButtonText(button: addChannelBtn, buttonName: "Add +", fontColor: .systemGray, alignment: .center, font: AVENIR_REGULAR, size: 13.0)
    }
    
    func getChannels() {
        MessageSerivce.instance.findAllChannelss { (success) in
            if success {
                self.tableView.reloadData()
                if MessageSerivce.instance.channels.count > 0 {
                    self.tableView.selectRowIndexes(IndexSet(integer: self.selectedChannelIndex), byExtendingSelection: false)
                }
            }
        }
    }

    @IBAction func addChannelBtnClicked(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let modalDict: [String: ModalType] = [USER_INFO_MODAL: ModalType.addChannel]
            NotificationCenter.default.post(name: NOTIF_PRESENT_MODAL, object: nil, userInfo: modalDict)
        } else {
            let loginDict: [String: ModalType] = [USER_INFO_MODAL : ModalType.logIn]
            NotificationCenter.default.post(name: NOTIF_PRESENT_MODAL, object: nil, userInfo: loginDict) 
        }
    }
    
    @objc func dataDidChange(_ nofif: Notification) {
        if AuthService.instance.isLoggedIn {
            usernameLbl.stringValue = UserDataService.instance.name
            getChannels()
        } else {
            usernameLbl.stringValue = ""
        }
    }
}


extension ChannelVC: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return MessageSerivce.instance.channels.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let channel = MessageSerivce.instance.channels[row]
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "channelCell"), owner: nil) as? ChannelCell {
            cell.configureCell(channel: channel, selectedChannel: selectedChannelIndex, row: row)
            return cell
        } else {
            return NSTableCellView()
        }
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        selectedChannelIndex = tableView.selectedRow
        let channel = MessageSerivce.instance.channels[selectedChannelIndex]
        selectedChannel = channel
        chatVC?.updateWithChannel(channel: channel)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 30.0
    }
}



