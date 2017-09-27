//
//  Album.swift
//  DragDrop
//
//  Created by Taylor Mott on 21-Sep-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import UIKit

class Album {
    let identifier = UUID()
    let title: String
    var pictures: [Picture]
    
    init(title: String = "", pictures: [Picture] = [Picture]()) {
        self.title = title
        self.pictures = pictures
    }
}

extension Album: Equatable {
    static func ==(lhs: Album, rhs: Album) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
