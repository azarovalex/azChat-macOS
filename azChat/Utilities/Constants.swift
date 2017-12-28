//
//  Constants.swift
//  azChat
//
//  Created by Alex Azarov on 09/12/2017.
//  Copyright © 2017 Alex Azarov. All rights reserved.
//

import Cocoa

typealias CompletionHandler = (_ Success: Bool) -> ()

// URL constants
// let BASE_URL = "http://localhost:3005/v1/"
let BASE_URL = "https://az-chat.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_ADD_USER = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel/"
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel/"

// Colors
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
let NOTIF_DATA_CHANGED  = Notification.Name("notifUserDataChanged")

// User defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Headers
let HEADER = [
    "Content-type": "application/json; charset=utf-8"
]
let BEARER_HEADER = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-type": "application/json; charset=utf-8"
]
