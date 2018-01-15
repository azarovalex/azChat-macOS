//
//  ChatCell.swift
//  azChat
//
//  Created by Alex Azarov on 10/01/2018.
//  Copyright © 2018 Alex Azarov. All rights reserved.
//

import Cocoa

class ChatCell: NSTableCellView {

    @IBOutlet weak var profileImage: NSImageView!
    @IBOutlet weak var usernameLbl: NSTextField!
    @IBOutlet weak var timeStampLbl: NSTextField!
    @IBOutlet weak var messageBodyLbl: NSTextField!
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        profileImage.wantsLayer = true
        profileImage.layer?.cornerRadius = 6
        profileImage.layer?.borderColor = NSColor.gray.cgColor
        profileImage.layer?.borderWidth = 2
        
    }
    
    func configureCell(chat: Message) {
        messageBodyLbl.stringValue = chat.message
        usernameLbl.stringValue = chat.username
        profileImage.image = NSImage(named: NSImage.Name(rawValue: chat.userAvatar!))
        profileImage.wantsLayer = true
        profileImage.layer?.backgroundColor = UserDataService.instance.returnCGColor(components: chat.userAvatarColor)
        
        guard var isoDate = chat.timeStamp else { return }
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = String(isoDate[..<end])
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timeStampLbl.stringValue = finalDate
        }
    }
    
}
