//
//  RecruitListCell.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/17.
//

import UIKit

class RecruitListCell: UITableViewCell {
    
    static let reuseIdentifier = "RecruitListCell"
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
