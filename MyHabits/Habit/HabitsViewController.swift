//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Dmitriy Chernov on 12.12.2020.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        cv.toAutoLayout()
        
        cv.dataSource = self
        cv.delegate = self
        
        cv.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.reuseID)
        cv.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.reuseID)
        
        return cv
    }()
    
    private lazy var habitStore: HabitsStore = {
        return HabitsStore.shared
    }()
    
    private lazy var callbackStore: HabitViewControllerCallbackStore = {
        return HabitViewControllerCallbackStore.instance
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(self) view did load")
        setupLayout()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        callbackStore.callback = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        callbackStore.callback = nil
    }
    
    
    private func setupLayout() {
        view.addSubview(collectionView)
        let hackTop: CGFloat = 50
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: hackTop),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension HabitsViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitStore.habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HabitCollectionViewCell.reuseID,
            for: indexPath
        ) as! HabitCollectionViewCell
        
        let habit = habitStore.habits[indexPath.item]
        cell.setData(
            position: indexPath.item,
            name: habit.name,
            dateString: habit.dateString,
            color: habit.color,
            habitTapCallback: self
        )
        return cell
    }
    
}

extension HabitsViewController : HabitTapCallback {
    func onTap(position: Int) {
        let controller = HabitViewController()
        controller.habitPosition = position
        controller.habit = habitStore.habits[position]
        present(controller, animated: true, completion: nil)
    }
}

extension HabitsViewController: UICollectionViewDelegate {
    
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    private var baseInset: CGFloat { 16 }
    private var cellSpace: CGFloat { 12 }
    private var cellHeight: CGFloat { 130 }
    private var progressCellHeight: CGFloat { 60 }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.frame.width - baseInset*2
        return CGSize(width: width, height: cellHeight)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return cellSpace
    }
    
}

extension HabitsViewController : HabitViewControllerCallback {
    func onNewHabit() {
        collectionView.reloadData()
    }
    
    func onUpdateHabit() {
        collectionView.reloadData()
    }
}
