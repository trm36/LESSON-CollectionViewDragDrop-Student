//
//  AlbumController.swift
//  DragDrop
//
//  Created by Taylor Mott on 21-Sep-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import UIKit

class AlbumController {
    static let sharedInstance = AlbumController()
    
    private(set) var albums = [Album]()
    
    init() {
        self.loadSampleData()
    }
    
    func add(_ image: UIImage, to album: Album?, at index: Int) {
        let picture = Picture(image: image)
        album?.pictures.insert(picture, at: index)
    }
    
    func add(_ images: [UIImage], to album: Album?, at index: Int) {
        for image in images {
            let picture = Picture(image: image)
            album?.pictures.insert(picture, at: index)
        }
    }
    
    func move(_ picture: Picture, to album: Album?, at index: Int) {
        guard let album = album,
            let sourceAlbumIndex = albums.index(where: { album in album.pictures.contains(picture) }),
            let indexOfPictureInSourceAlbum = albums[sourceAlbumIndex].pictures.index(of: picture),
            let destinationAlbumIndex = albums.index(of: album) else { return }
        
        albums[sourceAlbumIndex].pictures.remove(at: indexOfPictureInSourceAlbum)
        albums[destinationAlbumIndex].pictures.insert(picture, at: index)
    }
    
    func reorder(_ picture: Picture, in album: Album?, to destinationIndex: Int) {
        guard let album = album, let sourceIndex = album.pictures.index(of: picture) else { return }
        
        album.pictures.remove(at: sourceIndex)
        album.pictures.insert(picture, at: destinationIndex)
    }
}

extension AlbumController {
    private func loadSampleData() {
        guard let imageA0 = UIImage(named: "England - 0"),
            let imageA1 = UIImage(named: "England - 1"),
            let imageA2 = UIImage(named: "England - 2"),
            let imageA3 = UIImage(named: "England - 3"),
            let imageA4 = UIImage(named: "England - 4"),
            let imageA5 = UIImage(named: "England - 5"),
            let imageB0 = UIImage(named: "France - 0"),
            let imageB1 = UIImage(named: "France - 1"),
            let imageB2 = UIImage(named: "France - 2"),
            let imageB3 = UIImage(named: "France - 3"),
            let imageC0 = UIImage(named: "Italy - 0"),
            let imageC1 = UIImage(named: "Italy - 1"),
            let imageC2 = UIImage(named: "Italy - 2"),
            let imageC3 = UIImage(named: "Italy - 3"),
            let imageC4 = UIImage(named: "Italy - 4"),
            let imageD0 = UIImage(named: "Utah - 0") else { return }
        
        
        let pictureA0 = Picture(image: imageA0)
        let pictureA1 = Picture(image: imageA1)
        let pictureA2 = Picture(image: imageA2)
        let pictureA3 = Picture(image: imageA3)
        let pictureA4 = Picture(image: imageA4)
        let pictureA5 = Picture(image: imageA5)
        
        let pictureB0 = Picture(image: imageB0)
        let pictureB1 = Picture(image: imageB1)
        let pictureB2 = Picture(image: imageB2)
        let pictureB3 = Picture(image: imageB3)
        
        let pictureC0 = Picture(image: imageC0)
        let pictureC1 = Picture(image: imageC1)
        let pictureC2 = Picture(image: imageC2)
        let pictureC3 = Picture(image: imageC3)
        let pictureC4 = Picture(image: imageC4)
        
        let pictureD0 = Picture(image: imageD0)
        
        let albumA = Album(title: "England", pictures: [pictureA0, pictureA1, pictureA2, pictureA3, pictureA4, pictureA5])
        let albumB = Album(title: "France", pictures: [pictureB0, pictureB1, pictureB2, pictureB3])
        let albumC = Album(title: "Italy", pictures: [pictureC0, pictureC1, pictureC2, pictureC3, pictureC4])
        let albumD = Album(title: "Utah", pictures: [pictureD0])
        
        self.albums = [albumA, albumB, albumC, albumD]
    }
}
