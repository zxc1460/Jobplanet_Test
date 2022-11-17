//
//  RatingCell.swift
//  Jobplanet-test
//
//  Created by Seok on 2022/11/18.
//

import UIKit
import Domain

class RatingCell: UITableViewCell {
    
    static let reuseIdentifier = "RatingCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    func bind(_ rating: Rating) {
        self.titleLabel.text = rating.type
        self.ratingLabel.text = String(format: "%.1f", rating.rating)
    }
}
