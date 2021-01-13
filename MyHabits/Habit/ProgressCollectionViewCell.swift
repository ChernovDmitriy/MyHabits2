//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Dmitriy Chernov on 12.12.2020.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private let verticalInset: CGFloat = 10
    private let horizontalInset: CGFloat = 12
    
    private lazy var progressView: UIProgressView = {
        let pv = UIProgressView()
        pv.toAutoLayout()
        
        pv.backgroundColor = Styles.mediumGrayColor
        pv.progressTintColor = Styles.violetColor
        pv.layer.cornerRadius = 4
        pv.layer.masksToBounds = true
        
        return pv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.applyFootnoteStyle()
        
        return label
    }()
    
    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.applyFootnoteStyle()
        
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }

    func setData(progress: Int, title: String) {
        progressView.progress = Float(progress)
        titleLabel.text = title
    }
    
    private func initLayout() {
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(progressView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(percentLabel)
        
        initConstraints()
    }
    
    private func initConstraints() {
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalInset),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalInset),
            
            percentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalInset),
            percentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: horizontalInset),
            
            progressView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: verticalInset),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalInset),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: horizontalInset)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
