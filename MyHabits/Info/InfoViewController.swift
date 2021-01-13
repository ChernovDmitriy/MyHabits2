//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Dmitriy Chernov on 12.12.2020.
//

import UIKit

class InfoViewController: UIViewController {
    
    private let titleInset: CGFloat = 22
    private let baseInset: CGFloat = 16
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.applyTitle3Style()
        
        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.applyBodyStyle()
        
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupConstraints()
        setData(title: InfoStorage.headerText, body: InfoStorage.bodyText)
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
    }
    
    private func setupConstraints() {
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: titleInset),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: baseInset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -baseInset),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: baseInset),
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: baseInset),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -baseInset),
            bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -baseInset)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setData(title: String, body: String) {
        titleLabel.text = title
        bodyLabel.text = body
    }
}
