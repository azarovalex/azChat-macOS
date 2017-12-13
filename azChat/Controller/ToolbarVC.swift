//
//  ToolbarVC.swift
//  azChat
//
//  Created by Alex Azarov on 09/12/2017.
//  Copyright © 2017 Alex Azarov. All rights reserved.
//

import Cocoa

enum ModalType{
    case logIn
    case createAccount
}

class ToolbarVC: NSViewController {
    
    // Outlets
    @IBOutlet weak var loginImg: NSImageView!
    @IBOutlet weak var loginLbl: NSTextField!
    @IBOutlet weak var loginStack: NSStackView!
    
    // Variables
    var modalBGView : ClickBlockingView!
    var modalView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        setUpView()
    }
    
    func setUpView() {
        NotificationCenter.default.addObserver(self, selector: #selector(ToolbarVC.presentModal(_:)), name: NOTIF_PRESENT_MODAL, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ToolbarVC.closeModalNofit(_:)), name: NOTIF_CLOSE_MODAL, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ToolbarVC.dataDidChange(_:)), name: NOTIF_DATA_CHANGED, object: nil)
        
        view.wantsLayer = true
        view.layer?.backgroundColor = chatGreen.cgColor
        
        loginStack.gestureRecognizers.removeAll()
        let profilePage = NSClickGestureRecognizer(target: self, action: #selector(ToolbarVC.openProfilePage(_:)))
        loginStack.addGestureRecognizer(profilePage)
    }
    
    @objc func openProfilePage(_ recognizer: NSClickGestureRecognizer) {
        let loginDict: [String: ModalType] = [USER_INFO_MODAL: ModalType.logIn]
        NotificationCenter.default.post(name: NOTIF_PRESENT_MODAL, object: nil, userInfo: loginDict)
        
    }
    
    @objc func presentModal(_ notif: Notification) {
        var modalWidth = CGFloat(0.0)
        var modalHeight = CGFloat(0.0)
        
        if modalBGView == nil {
            modalBGView = ClickBlockingView()
            modalBGView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(modalBGView, positioned: .above, relativeTo: loginStack)
            let topCn = NSLayoutConstraint(item: modalBGView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 50)
            let leftCn = NSLayoutConstraint(item: modalBGView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
            let bottomCn = NSLayoutConstraint(item: modalBGView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
            let rightCn = NSLayoutConstraint(item: modalBGView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
            view.addConstraints([topCn, leftCn, rightCn, bottomCn])
            modalBGView.wantsLayer = true
            modalBGView.layer?.backgroundColor = CGColor.black
            modalBGView.alphaValue = 0.0
            
            let closeBackgroungClick = NSClickGestureRecognizer(target: self, action: #selector(ToolbarVC.closeModalClick(_:)))
            modalBGView.addGestureRecognizer(closeBackgroungClick)
        }
        
        // Set up xib
        guard let modalType = notif.userInfo?[USER_INFO_MODAL] as? ModalType else { return }
        switch modalType {
        case ModalType.logIn:
            modalView = ModalLogin()
            modalWidth = 475
            modalHeight = 300
        case ModalType.createAccount:
            modalView = ModalCreateAccount()
            modalWidth = 475
            modalHeight = 300
        }
        
        modalView.wantsLayer = true
        modalView.translatesAutoresizingMaskIntoConstraints = false
        modalView.alphaValue = 0
        view.addSubview(modalView, positioned: .above, relativeTo: modalBGView)
        
        let horizontalCn = modalView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalCn = modalView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthCn = modalView.widthAnchor.constraint(equalToConstant: modalWidth)
        let heightCn = modalView.heightAnchor.constraint(equalToConstant: modalHeight)
        
        NSLayoutConstraint.activate([horizontalCn, verticalCn, widthCn, heightCn])
        
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.5
            modalBGView.animator().alphaValue = 0.6
            modalView.animator().alphaValue = 1.0
            self.view.layoutSubtreeIfNeeded()
        }, completionHandler: nil)
    }
    
    @objc func closeModalNofit(_ notif: Notification) {
        if let removeImmediately = notif.userInfo?[USER_INFO_REMOVE_IMMEDIATELY] as? Bool {
            closeModal(removeImmediately)
        } else {
            closeModal()
        }
    }
    
    @objc func closeModalClick(_ recognizer: NSClickGestureRecognizer) {
        closeModal()
    }
    
    func closeModal(_ removeImmediately: Bool = false) {
        if removeImmediately {
            self.modalView.removeFromSuperview()
        } else { NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.5
            modalBGView.animator().alphaValue = 0.0
            modalView.animator().alphaValue = 0.0
            self.view.layoutSubtreeIfNeeded()
        }, completionHandler: {
            if self.modalBGView != nil {
                self.modalBGView.removeFromSuperview()
                self.modalBGView = nil
                self.modalView.removeFromSuperview()
                self.modalView = nil
            }
        })
        }
    }
    
    @objc func dataDidChange(_ nofif: Notification) {
        if AuthService.instance.isLoggedIn {
            loginLbl.stringValue = UserDataService.instance.name
            loginImg.wantsLayer = true
            loginImg.layer?.cornerRadius = 5
            loginImg.layer?.borderColor = NSColor.white.cgColor
            loginImg.layer?.borderWidth = 1
            loginImg.image = NSImage(named: NSImage.Name(rawValue: UserDataService.instance.avatarName))
            // TODO: add avatar color
        } else {
            loginImg.wantsLayer = true
            loginImg.layer?.borderWidth = 0
            loginImg.image = NSImage(named: NSImage.Name(rawValue: "profileDefault"))
            loginImg.layer?.backgroundColor = CGColor.clear
        }
    }
    
}
