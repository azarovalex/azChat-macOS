//
//  AnimalCell.swift
//  azChat
//
//  Created by Alex Azarov on 18/12/2017.
//  Copyright © 2017 Alex Azarov. All rights reserved.
//

import Cocoa

class AnimalCell: NSCollectionViewItem {

    @IBOutlet weak var animalImg: NSImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        setUpView()
    }
    
    func configureCell(index: Int, type: AnimalType) {
        if type == AnimalType.dark {
            animalImg.image = NSImage(named: NSImage.Name(rawValue: "dark\(index)"))
            view.wantsLayer = true
            view.layer?.backgroundColor = NSColor.lightGray.cgColor
        } else {
            animalImg.image = NSImage(named: NSImage.Name(rawValue: "light\(index)"))
            view.wantsLayer = true
            view.layer?.backgroundColor = NSColor.gray.cgColor
        }
        
    }
    
    func setUpView() {
        view.wantsLayer = true
        view.layer?.borderColor = NSColor.darkGray.cgColor
        view.layer?.cornerRadius = 10
        view.layer?.borderWidth = 2
    }
}
