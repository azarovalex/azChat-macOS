//
//  Constants.swift
//  azChat
//
//  Created by Alex Azarov on 09/12/2017.
//  Copyright © 2017 Alex Azarov. All rights reserved.
//

import Cocoa

// Colors
// let chatPurple = NSColor.hexColor(rgbValue: 0xffebee)
let chatPurple = NSColor(calibratedRed: 255/255, green: 0xeb/0xff, blue: 0xee/0xff, alpha: 1)

let chatGreen = NSColor.hexColor(rgbValue: 0xe57373)

// Fonts
let AVENIR_REGULAR = "AvenirNext-Regular"
let AVENIR_BOLD = "AvenirNext-Bold"

// Notification Constants
let USER_INFO_MODAL = "modalUserInfo"
let NOTIF_PRESENT_MODAL = Notification.Name("presentModal")
let NOTIF_CLOSE_MODAL = Notification.Name("closeModal")
let USER_INFO_REMOVE_IMMEDIATELY = "modalRemoveImmediately"
