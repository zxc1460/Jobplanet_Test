//
//  TagCell.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/16.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    static let reuseIdentifier = "TagCell"

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(title: String) {
        self.titleLabel.text = title
    }
}
