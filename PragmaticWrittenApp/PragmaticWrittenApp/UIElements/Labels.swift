//
//  Labels.swift
//  PragmaticWrittenApp
//
//  Created by Sebastian on 22/03/22.
//

import UIKit

class PrimaryHeader: DesingSystemLabel {
    override func setup() {
        font = UIFont.boldSystemFont(ofSize: 32)
    }
}

class PrimaryLabel: DesingSystemLabel {
    override func setup() {
        font = UIFont.boldSystemFont(ofSize: 16)
    }
}

class SecondaryLabel: DesingSystemLabel {
    override func setup() {
        font = UIFont.systemFont(ofSize: 16)
    }
}

class SmallLabel: DesingSystemLabel {
    override func setup() {
        font = UIFont.italicSystemFont(ofSize: 10)
    }
}

class DesingSystemLabel : UILabel, DesignSystem {
    
    func setup() {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
}
