//
//  HabitViewControllerCallbackStore.swift
//  MyHabits
//
//  Created by Dmitriy Chernov on 11.01.2021.
//

final class HabitViewControllerCallbackStore {
    
    static let instance: HabitViewControllerCallbackStore = .init()
    
    var callback: HabitViewControllerCallback? = nil

    private init() {
        
    }
    
}
