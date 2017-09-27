//
//  AlbumListTableViewController.swift
//  DragDrop
//
//  Created by Taylor Mott on 21-Sep-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import UIKit

class AlbumListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlbumController.sharedInstance.albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let album = AlbumController.sharedInstance.albums[indexPath.row]
        let thumbnail = album.pictures.first?.generateThumbnail(with: CGSize(width: 50, height: 50))
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath)
        cell.textLabel?.text = album.title
        cell.imageView?.image = thumbnail
        
        return cell
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoCollectionViewController", let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            let album = AlbumController.sharedInstance.albums[indexPath.row]
            let navigationController = segue.destination as? UINavigationController
            let albumCollectionViewController = navigationController?.viewControllers.first as? AlbumCollectionViewController
            albumCollectionViewController?.album = album
        }
    }
}

