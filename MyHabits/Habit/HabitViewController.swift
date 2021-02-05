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
    
    var habitPosition: Int? = nil
    var habit: Habit? = nil
    
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
        if habit != nil {
            textField.text = habit?.name
        }
        
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
        imageView.backgroundColor = habit != nil ? habit?.color : habitColor
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
        label.text = habit != nil ? habit?.dateString : "Каждый день в ".uppercased()
        
        return label
    }()
    
    private lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.toAutoLayout()
        
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        if (habit != nil) {
            picker.date = habit!.date
        }
        picker.addTarget(self, action: #selector(datePickerChange(picker:)), for: .valueChanged)
        return picker
    }()
    
    
    private lazy var deleteHabitLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Удалить привычку"
        label.textColor = .red
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(deleteHabitTap))
        tapGestureRecognizer.delegate = self
        
        label.addGestureRecognizer(tapGestureRecognizer)
        
        return label
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
    
    
    @objc func deleteHabitTap() {
        if (habitPosition != nil) {
            habitStore.habits.remove(at: habitPosition!)
        }
        HabitViewControllerCallbackStore.instance.callback?.onNewHabit()
        popBack()
    }
    
    @objc func datePickerChange(picker: UIDatePicker) {
        print("change time to \(picker.date)")
        habit?.date = picker.date
        timeLabel.text = habit?.dateString
    }
    
    private func initLayout() {
        view.backgroundColor = .white
        view.addSubview(nameTitleLabel)
        view.addSubview(nameTextField)
        view.addSubview(colorTitleLabel)
        view.addSubview(colorImageView)
        view.addSubview(timeTitleLabel)
        view.addSubview(timeLabel)
        view.addSubview(timePicker)
        if (habitPosition != nil) {
            view.addSubview(deleteHabitLabel)
        }
    }
    
    private func initConstraints() {
//        let hackTop: CGFloat = 50
        var constraints = [
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
        if (habit != nil) {
            constraints.append(contentsOf: [
                deleteHabitLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                deleteHabitLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -26)
            ])
        } else {
            habit = Habit(
                name: nameTextField.text ?? "",
                date: timePicker.date,
                color: colorImageView.backgroundColor ?? habitColor
            )
            timeLabel.text = habit?.dateString
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    private func saveHabit() {
        habit?.color = colorImageView.backgroundColor ?? habitColor
        habit?.date = timePicker.date
        habit?.name = nameTextField.text ?? ""
        if (habitPosition != nil) {
            habitStore.habits.remove(at: habitPosition!)
            habitStore.habits.insert(habit!, at: habitPosition!)
        } else {
            habitStore.habits.append(habit!)
        }
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


