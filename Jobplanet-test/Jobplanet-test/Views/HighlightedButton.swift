//
//  HighlightedButton.swift
//  Jobplanet-test
//
//  Created by Seok on 2022/11/15.
//

import UIKit

class HighlightedButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? UIColor.jpGreen : UIColor.white
            self.layer.borderWidth = isHighlighted ? 0 : 1
        }
    }
}
