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
                print(response.result.error as Any)
            }
        }
        
    }
}
