//
//  HighlightedButton.swift
//  Jobplanet-test
//
//  Created by Seok on 2022/11/15.
//

import UIKit

class HighlightedButton: UIButton {
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? UIColor.jpGreen : UIColor.white
            self.tintColor = isSelected ? UIColor.jpGreen : UIColor.white
            self.layer.borderWidth = isSelected ? 0 : 1
            self.titleLabel?.font = isSelected ? UIFont.fontWithName(type: .bold, size: 15) : UIFont.fontWithName(type: .regular, size: 15)
        }
    }
}
