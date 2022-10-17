//
//  BookCell.swift
//  ReadmeTableView
//
//  Created by Sebastian on 17/10/22.
//

import Foundation
import UIKit

class BookCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var reviewLabel: UILabel!
    
    @IBOutlet var readmeBookmark: UIImageView!
    @IBOutlet var bookThumbnail: UIImageView!
}
