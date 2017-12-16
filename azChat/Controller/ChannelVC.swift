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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        setUpView()
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.dataDidChange(_:)), name: NOTIF_DATA_CHANGED, object: nil)
    }
    
    func setUpView() {
        view.wantsLayer = true
        view.layer?.backgroundColor = chatPurple.cgColor
        addChannelBtn.styleButtonText(button: addChannelBtn, buttonName: "Add +", fontColor: .systemGray, alignment: .center, font: AVENIR_REGULAR, size: 13.0)
    }

    @IBAction func addChannelBtnClicked(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            // Add a channel
        } else {
            let loginDict: [String: ModalType] = [USER_INFO_MODAL : ModalType.logIn]
            NotificationCenter.default.post(name: NOTIF_PRESENT_MODAL, object: nil, userInfo: loginDict) 
        }
    }
    
    @objc func dataDidChange(_ nofif: Notification) {
        if AuthService.instance.isLoggedIn {
            usernameLbl.stringValue = UserDataService.instance.name
        } else {
            usernameLbl.stringValue = ""
        }
    }
}
