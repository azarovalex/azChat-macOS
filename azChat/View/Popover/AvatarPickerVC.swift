//
//  AvatarPickerVC.swift
//  azChat
//
//  Created by Alex Azarov on 18/12/2017.
//  Copyright © 2017 Alex Azarov. All rights reserved.
//

import Cocoa

enum AnimalType {
    case dark
    case light
}

class AvatarPickerVC: NSViewController, NSCollectionViewDelegate, NSCollectionViewDataSource, NSCollectionViewDelegateFlowLayout {

    // Outlets
    @IBOutlet weak var segmentControl: NSSegmentedControl!
    @IBOutlet weak var collectionView: NSCollectionView!
    
    // Variables
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSMakeSize(85.0, 85.0)
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let cell = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "AnimalCell"), for: indexPath)
        return cell
    }
    
}
