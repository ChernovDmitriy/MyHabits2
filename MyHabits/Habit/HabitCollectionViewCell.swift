//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Dmitriy Chernov on 12.12.2020.
//

import UIKit

protocol HabitTapCallback {
    func onTap(position: Int)
}

class HabitCollectionViewCell: UICollectionViewCell {
    
    var habitTapCallback: (() -> Void)?
    
    private let baseInset: CGFloat = 20
    private let imageSize: CGFloat = 36
    
    var habit = Habit(name: "Выпить стакан воды перед завтраком", date: Date(), color: .systemRed)
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.applyHeadlineStyle()
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.applyFootnoteStyle()
        label.textColor = .systemGray
        
        return label
    }()
    
    private lazy var trackerLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.applyCaptionStyle()
        label.text = "Подряд: \(habit.trackDates.count)"
        label.textColor = .systemGray
        
        return label
    }()
    
    private lazy var checkBoxButton: UIButton = {
        let button = UIButton()
        button.roundCornerWithRadius(18, top: true, bottom: true, shadowEnabled: false)
        button.toAutoLayout()
        button.backgroundColor = .white
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(checkBoxButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    @objc func checkBoxButtonPressed() {
        if !habit.isAlreadyTakenToday {
            HabitsStore.shared.track(habit)
            checkBoxButton.backgroundColor = habit.color
        }
        habitTapCallback?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initLayout()
    }
    
    func setData(habit: Habit) {
        self.habit = habit
        
        nameLabel.textColor = habit.color
        nameLabel.text = habit.name
        dateLabel.text = habit.dateString
        checkBoxButton.layer.borderColor = habit.color.cgColor
        trackerLabel.text = "Подряд: \(habit.trackDates.count)"
        
        if habit.isAlreadyTakenToday {
            checkBoxButton.backgroundColor = habit.color
        } else {
            checkBoxButton.backgroundColor = .white
        }
    }
    
    private func initLayout() {
        contentView.roundCornerWithRadius(6, top: true, bottom: true, shadowEnabled: false)
        contentView.backgroundColor = .white
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(trackerLabel)
        contentView.addSubview(checkBoxButton)
        
        let constraints = [
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: baseInset),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: baseInset),
            nameLabel.trailingAnchor.constraint(equalTo: checkBoxButton.leadingAnchor, constant: -baseInset),
            
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            trackerLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            trackerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -baseInset),
            
            checkBoxButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            checkBoxButton.heightAnchor.constraint(equalToConstant: imageSize),
            checkBoxButton.widthAnchor.constraint(equalToConstant: imageSize),
            checkBoxButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -47)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
