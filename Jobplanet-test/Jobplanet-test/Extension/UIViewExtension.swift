//
//  UIViewExtension.swift
//  Jobplanet-test
//
//  Created by Seok on 2022/11/15.
//

import UIKit

extension UIView {
    @IBInspectable var boderColor: UIColor {
        get {
            let color = self.layer.borderColor ?? UIColor.clear.cgColor
            
            return UIColor(cgColor: color)
        }
        
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
