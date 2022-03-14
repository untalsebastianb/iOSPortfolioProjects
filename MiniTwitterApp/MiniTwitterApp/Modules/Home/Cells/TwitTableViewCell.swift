//
//  TwitTableViewCell.swift
//  MiniTwitterApp
//
//  Created by Sebastian on 14/03/22.
//

import UIKit
import Kingfisher

class TwitTableViewCell: UITableViewCell {
//  MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var twitImageView: UIImageView!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCellWith(twiitResponse: TwiitResponse ){
        nameLabel.text = twiitResponse.author.names
        nickNameLabel.text = twiitResponse.author.nickname
        messageLabel.text = twiitResponse.text
        
        if twiitResponse.hasImage {
            twitImageView.kf.setImage(with: URL(string: twiitResponse.imageUrl))
        } else {
            twitImageView.isHidden = true
        }
    }
    
}
