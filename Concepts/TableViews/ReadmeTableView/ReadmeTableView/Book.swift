//
//  Book.swift
//  ReadmeTableView
//
//  Created by Sebastian on 8/10/22.
//

import Foundation
import UIKit

struct Book {
    let title: String
    let author: String
    var image: UIImage {
        Library.loadImage(forBook: self) ??
        LibrarySymbol.letterSquare(letter: title.first).image
    }
}
