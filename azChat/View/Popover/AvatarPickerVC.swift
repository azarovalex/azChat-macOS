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
    var animalType = AnimalType.light
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        if segmentControl.selectedSegment == 0 {
            animalType = .dark
        } else {
            animalType = .light
        }
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        segmentControl.cell?.controlTint = .clearControlTint
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSMakeSize(85.0, 85.0)
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        if let selectedIndexPaths = collectionView.selectionIndexPaths.first {
            if animalType == .dark {
                UserDataService.instance.avatarName = "dark\(selectedIndexPaths.item)"
            } else {
                UserDataService.instance.avatarName = "light\(selectedIndexPaths.item)"
            }
            view.window?.cancelOperation(nil)
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let cell = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "AnimalCell"), for: indexPath)
        guard let animalCell = cell as? AnimalCell else {
            return NSCollectionViewItem()
        }
        animalCell.configureCell(index: indexPath.item, type: animalType)
        return animalCell
    }
    
}
