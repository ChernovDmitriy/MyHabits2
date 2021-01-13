//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Dmitriy Chernov on 13.12.2020.
//

import UIKit

class HabitViewController: UIViewController {
    
    private let horizontalInset: CGFloat = 16
    private let imageSize: CGFloat = 30
    
    private var habitColor: UIColor = .orange
    
    private lazy var habitStore: HabitsStore = {
        return HabitsStore.shared
    }()
    
    private lazy var nameTitleLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        
        label.text = "Название".uppercased()
        
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.toAutoLayout()
        
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        
        return textField
    }()
    
    private lazy var colorTitleLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        
        label.text = "Цвет".uppercased()
        
        return label
    }()
    
    private lazy var colorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = habitColor
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize/2
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(colorViewTap))
        tapGestureRecognizer.delegate = self
        
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        return imageView
    }()
    
    private lazy var timeTitleLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        
        label.text = "Время".uppercased()
        
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.toAutoLayout()
        
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.addTarget(self, action: #selector(datePickerChange(picker:)), for: .valueChanged)
        return picker
    }()
    
    @IBAction func createAction(_ sender: Any) {
        saveHabit()
        popBack()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        popBack()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
        initConstraints()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        view.endEditing(true)
    }
    
    @objc func colorViewTap() {
        let controller = UIColorPickerViewController()
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    @objc func datePickerChange(picker: UIDatePicker) {
        print("change time to \(picker.date)")
    }
    
    private func initLayout() {
        view.addSubview(nameTitleLabel)
        view.addSubview(nameTextField)
        view.addSubview(colorTitleLabel)
        view.addSubview(colorImageView)
        view.addSubview(timeTitleLabel)
        view.addSubview(timeLabel)
        view.addSubview(timePicker)
    }
    
    private func initConstraints() {
//        let hackTop: CGFloat = 50
        let constraints = [
            nameTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 22),
            nameTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalInset),
            
            nameTextField.topAnchor.constraint(equalTo: nameTitleLabel.bottomAnchor, constant: 7),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalInset),
            
            colorTitleLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            colorTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalInset),
            
            colorImageView.topAnchor.constraint(equalTo: colorTitleLabel.bottomAnchor, constant: 7),
            colorImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalInset),
            colorImageView.widthAnchor.constraint(equalToConstant: imageSize),
            colorImageView.heightAnchor.constraint(equalToConstant: imageSize),
            
            timeTitleLabel.topAnchor.constraint(equalTo: colorImageView.bottomAnchor, constant: 15),
            timeTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalInset),
            
            timeLabel.topAnchor.constraint(equalTo: timeTitleLabel.bottomAnchor, constant: 7),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalInset),
            
            timePicker.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            timePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func saveHabit() {
        let habit = Habit(
            name: nameTextField.text ?? "",
            date: timePicker.date,
            color: colorImageView.backgroundColor ?? habitColor
        )
        habitStore.habits.append(habit)
        HabitViewControllerCallbackStore.instance.callback?.onNewHabit()
    }
    
    private func popBack() {
        dismiss(animated: true, completion: nil)
    }
}

extension HabitViewController : UIGestureRecognizerDelegate {

}

extension HabitViewController : UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorImageView.backgroundColor = viewController.selectedColor
    }
}


