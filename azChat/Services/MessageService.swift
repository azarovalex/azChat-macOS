//
//  MessageService.swift
//  azChat
//
//  Created by Alex Azarov on 19/12/2017.
//  Copyright © 2017 Alex Azarov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageSerivce {
    static let instance = MessageSerivce()
    
    var channels = [Channel]()
    var messages = [Message]()
    
    func findAllChannelss(completrion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                if let json = try! JSON(data: data).array {
                    for item in json {
                        let name = item["name"].stringValue
                        let channelDesription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: name, channelDescription: channelDesription, id: id)
                        self.channels.append(channel)
                    }
                    completrion(true)
                }
            } else {
                completrion(false)
                debugPrint (response.result.error as Any)
            }
        }
    }
    
    func findAllMessagesForChat(channelId: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).response { (response) in
            if response.error == nil {
                self.clearMessages()
                guard let data = response.data else { return }
                if let json = try! JSON(data: data).array {
                    for item in json {
                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let id = item["_id"].stringValue
                        let username = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        
                        let message = Message(message: messageBody, username: username, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                        self.messages.append(message)
                    }
                    completion(true)
                }
            } else {
                completion(false)
                debugPrint(response.error as Any)
            }
        }
    }
    
    func clearMessages() {
        messages.removeAll()
    }
}
