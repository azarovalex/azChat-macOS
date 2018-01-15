//
//  AppDelegate.swift
//  azChat
//
//  Created by Alex Azarov on 09/12/2017.
//  Copyright © 2017 Alex Azarov. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }
    func applicationDidBecomeActive(_ notification: Notification) {
         SocketService.instance.establishConnection()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
         SocketService.instance.closeConnection()
    }
    
    func applicationWillHide(_ notification: Notification) {
        UserDataService.instance.isMinimazing = true
    }

    func applicationDidUnhide(_ notification: Notification) {
        UserDataService.instance.isMinimazing = false
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

}

