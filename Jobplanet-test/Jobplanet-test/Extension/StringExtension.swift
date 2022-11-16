//
//  StringExtension.swift
//  Jobplanet-test
//
//  Created by Seok on 2022/11/16.
//

import Foundation
import UIKit

extension String {
    func textSize(from font: UIFont) -> CGSize {
        return CGSize(
            width: (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font]).width ?? .zero,
            height: (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font]).height ?? .zero
        )
    }
}
