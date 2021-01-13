//
//  Styles.swift
//  MyHabits
//
//  Created by Dmitriy Chernov on 12.12.2020.
//

import UIKit

class Styles {
    //MARK: colors
    static let darkGrayColor: UIColor = .systemGray
    static let mediumGrayColor: UIColor = .systemGray2
    static let lightGrayColor: UIColor = UIColor(displayP3Red: 242, green: 242, blue: 247, alpha: 0)
    static let violetColor: UIColor = UIColor(displayP3Red: 161, green: 22, blue: 204, alpha: 0)
    static let blueColor: UIColor = UIColor(displayP3Red: 41, green: 109, blue: 255, alpha: 0)
    static let greenColor: UIColor = UIColor(displayP3Red: 29, green: 179, blue: 34, alpha: 0)
    static let purpleColor: UIColor = UIColor(displayP3Red: 98, green: 54, blue: 255, alpha: 0)
    static let orangeColor: UIColor = UIColor(displayP3Red: 255, green: 179, blue: 79, alpha: 0)
    
//    //MARK: fonts
//    static let title3Font: UIFont = UIFont.systemFont(ofSize: 20)
//    static let headlineFont: UIFont = UIFont.systemFont(ofSize: 17)
//    static let bodyFont: UIFont = UIFont.systemFont(ofSize: 17)
//    static let footnoteFont: UIFont = UIFont.systemFont(ofSize: 13)
//    static let statusFootnoteFont: UIFont = UIFont.systemFont(ofSize: 13)
}

extension UILabel {
    func applyTitle3Style() {
        self.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.textColor = .black
    }
    
    func applyHeadlineStyle() {
        self.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        self.textColor = Styles.blueColor
    }
    
    func applyBodyStyle() {
        self.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        self.textColor = .black
    }
    
    func applyFootnoteStyle() {
        self.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.textColor = Styles.darkGrayColor
    }
    
    func applyStatusFootnoteStyle() {
        self.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        self.textColor = Styles.mediumGrayColor
    }
    
    func applyCaptionStyle() {
        self.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        self.textColor = Styles.lightGrayColor
    }
}
