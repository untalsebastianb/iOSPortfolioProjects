//
//  PostView.swift
//  PragmaticWrittenApp
//
//  Created by Sebastian on 22/03/22.
//

import UIKit
import SnapKit
import MagazineLayout

class PostCollectionViewCell: MagazineLayoutCollectionViewCell {
    
    struct ViewModel {
        let title: String
        let subtitle: String
        let postedBy: String
    }
    
    let titleLabel = PrimaryLabel()
    let subtitleLabel = SecondaryLabel()
    let postedByLabel = SmallLabel()
    
    let mainStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
    let leftSideStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    let rightSideStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setupMainStackView(){
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setup() {
        setupStyles()
        setupMainStackView()
        setupLeftSideStackView()
        setupRightSideStackView()
    }
    
    private func setupLeftSideStackView(){
        mainStackView.addArrangedSubview(leftSideStackView)
        let imageView = UIImageView()
        imageView.image = UIImage(named: "photoFill")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.snp.makeConstraints { make in
            make.size.equalTo(60)
        }

        leftSideStackView.addArrangedSubview(imageView)
        leftSideStackView.addArrangedSubview(postedByLabel)
    }
    
    private func setupRightSideStackView(){
        mainStackView.addArrangedSubview(rightSideStackView)
        rightSideStackView.addArrangedSubview(titleLabel)
        rightSideStackView.addArrangedSubview(subtitleLabel)
        
    }
    
    private func setupStyles(){
        backgroundColor = .lightGray
        layer.cornerRadius = 5
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
    }
    
    func set(_ viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        postedByLabel.text = viewModel.postedBy
    }
}
