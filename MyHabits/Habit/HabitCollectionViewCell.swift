//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Dmitriy Chernov on 12.12.2020.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    private let baseInset: CGFloat = 20
    private let imageSize: CGFloat = 36
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.applyHeadlineStyle()

        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.applyCaptionStyle()
        
        return label
    }()
    
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.applyFootnoteStyle()
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(name: String, dateString: String, color: UIColor) {
        print("setData: name: \(name), dateString: \(dateString), color: \(color)")
        nameLabel.text = name
        dateLabel.text = dateString
        dateLabel.text = "Каждый день в \(dateString)"
        imageView.layer.borderColor = color.cgColor
    }
    
    private func initLayout() {
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(imageView)
        
        initConstraints()
    }
    
    private func initConstraints() {
        let constraints = [
            contentView.heightAnchor.constraint(equalToConstant: 130),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: baseInset),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: baseInset),
            
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: baseInset),
            
            countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: baseInset),
            countLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            imageView.widthAnchor.constraint(equalToConstant: imageSize),
            imageView.heightAnchor.constraint(equalToConstant: imageSize),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
