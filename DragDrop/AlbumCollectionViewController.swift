//
//  AlbumCollectionViewController.swift
//  DragDrop
//
//  Created by Taylor Mott on 21-Sep-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import UIKit

private let reuseIdentifier = "pictureCell"

class AlbumCollectionViewController: UICollectionViewController {
    
    var album: Album? = AlbumController.sharedInstance.albums.first
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.dropDelegate = self
        self.collectionView?.dragDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = album?.title
        self.collectionView?.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return album?.pictures.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let pictureCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PictureCollectionViewCell else { return UICollectionViewCell() }
        
        let picture = self.album?.pictures[indexPath.item]
        
        pictureCell.imageView.image = picture?.image
        
        return pictureCell
    }
    
}

extension AlbumCollectionViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let insertionIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        
        switch coordinator.proposal.operation {
        case .move:
            for coordinatorItem in coordinator.items {
                guard let picture = coordinatorItem.dragItem.localObject as? Picture else { return }
                
                let albumContainsPicture = (album?.pictures.contains(picture) ?? false)
                if albumContainsPicture, let indexOfPicture = album?.pictures.index(of: picture) {
                    collectionView.performBatchUpdates({
                        AlbumController.sharedInstance.reorder(picture, in: self.album, to: insertionIndexPath.item)
                        collectionView.deleteItems(at: [IndexPath(item: indexOfPicture, section: 0)])
                        collectionView.insertItems(at: [insertionIndexPath])
                    })
                } else {
                    AlbumController.sharedInstance.move(picture, to: self.album, at: insertionIndexPath.item)
                    collectionView.insertItems(at: [insertionIndexPath])
                }
                
                coordinator.drop(coordinatorItem.dragItem, toItemAt: insertionIndexPath)
            }
        case .copy:
            if coordinator.session.canLoadObjects(ofClass: UIImage.self) {
                coordinator.session.loadObjects(ofClass: UIImage.self, completion: { (objects) in
                    collectionView.performBatchUpdates({
                        guard let images = objects as? [UIImage] else { return }
                        
                        for image in images {
                            AlbumController.sharedInstance.add(image, to: self.album, at: insertionIndexPath.item)
                            collectionView.insertItems(at: [insertionIndexPath])
                        }
                    })
                })
            }
        default:
            return
        }
    }
}

extension AlbumCollectionViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard let picture = album?.pictures[indexPath.item] else { return [] }
        let itemProvider = NSItemProvider(object: picture.image) //UIImage already conforms to NSItemProviderWriting
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = picture
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        guard let picture = album?.pictures[indexPath.item] else { return [] }
        let itemProvider = NSItemProvider(object: picture.image) //UIImage already conforms to NSItemProviderWriting
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = picture
        return [dragItem]
    }
    
    // MARK: - Drop Proposal
    func collectionView(_ collectionView: UICollectionView,
                        dropSessionDidUpdate session: UIDropSession,
                        withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        
        if session.localDragSession == nil { // drag started from outside of your app
            return UICollectionViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        } else { // drag started in your app
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
    }
}
