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
