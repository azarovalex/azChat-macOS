//
//  UserDataService.swift
//  azChat
//
//  Created by Alex Azarov on 13/12/2017.
//  Copyright © 2017 Alex Azarov. All rights reserved.
//

import Foundation

class UserDataService {
    static let instance = UserDataService()
    
    fileprivate var _id = ""
    fileprivate var _avatarColor = ""
    fileprivate var _avatarName = ""
    fileprivate var _email = ""
    fileprivate var _name = ""
    
    var id: String {
        get {
            return _id
        }
        set {
            _id = newValue
        }
    }
    
    var avatarColor: String {
        get {
            return _avatarColor
        }
        set {
            _avatarColor = newValue
        }
    }
    
    var avatarName: String {
        get {
            return _avatarName
        }
        set {
            _avatarName = newValue
        }
    }
    
    var email: String {
        get {
            return _email
        }
        set {
            _email = newValue
        }
    }
    
    var name: String {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }
    
    func logoutUser() {
        _id = ""
        _avatarName = ""
        _avatarColor = ""
        _email = ""
        _name = ""
        AuthService.instance.authToken = ""
        AuthService.instance.userEmail = ""
        AuthService.instance.isLoggedIn = false
    }
    
    func returnCGColor(components: String) -> CGColor {
//        [0.819260207423994, 0.0, 1.0, 1.0]
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a: NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaulColor = CGColor(red: 0.69, green: 0.85, blue: 0.99, alpha: 1.0)
        guard let rUnwrapped = r else { return defaulColor }
        guard let gUnwrapped = g else { return defaulColor }
        guard let bUnwrapped = b else { return defaulColor }
        guard let aUnwrapped = a else { return defaulColor }
        
        let rFloat = CGFloat(rUnwrapped.doubleValue)
        let gFloat = CGFloat(gUnwrapped.doubleValue)
        let bFloat = CGFloat(bUnwrapped.doubleValue)
        let aFloat = CGFloat(aUnwrapped.doubleValue)
        
        let newCGColor = CGColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        return newCGColor
    }
}
