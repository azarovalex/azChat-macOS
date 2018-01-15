//
//  SocketService.swift
//  azChat
//
//  Created by Alex Azarov on 17/12/2017.
//  Copyright © 2017 Alex Azarov. All rights reserved.
//

import Cocoa
import SocketIO

let manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])

class SocketService: NSObject {
    static let instance = SocketService()
    
    let socket = manager.defaultSocket
    
    override init() {
        super.init()
    }
    
    func establishConnection() {
        socket.connect()
    }

    func closeConnection() {
        socket.disconnect()
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        socket.on("channelCreated") { (dataArray, socketAck) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDescription = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDescription, id: channelId)
            MessageSerivce.instance.channels.append(newChannel)
            completion(true)
        }
    }
}
