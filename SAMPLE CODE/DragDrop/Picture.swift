//
//  Picture.swift
//  DragDrop
//
//  Created by Taylor Mott on 21-Sep-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import UIKit

class Picture {
    let identifier = UUID()
    let image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
    
    func generateThumbnail(with thumbnailSize: CGSize) -> UIImage {
        let imageSize = image.size
        
        let widthRatio = thumbnailSize.width / imageSize.width
        let heightRatio = thumbnailSize.height / imageSize.height
        let scaleFactor = widthRatio > heightRatio ? widthRatio : heightRatio
        
        let renderer = UIGraphicsImageRenderer(size: thumbnailSize)
        let thumbnail = renderer.image { _ in
            let size = CGSize(width: imageSize.width * scaleFactor, height: imageSize.height * scaleFactor)
            let x = (thumbnailSize.width - size.width) / 2.0
            let y = (thumbnailSize.height - size.height) / 2.0
            image.draw(in: CGRect(origin: CGPoint(x: x, y: y), size: size))
        }
        return thumbnail
    }
}

extension Picture: Equatable {
    static func ==(lhs: Picture, rhs: Picture) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
