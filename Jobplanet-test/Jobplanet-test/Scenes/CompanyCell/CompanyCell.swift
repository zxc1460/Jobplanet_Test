//
//  CompanyCell.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/17.
//

import UIKit

class CompanyCell: UITableViewCell {
    
    static let reuseIdentifier = "CompanyCell"

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var salaryView: UIView!
    @IBOutlet weak var interviewView: UIView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var companyIconImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var industryLabel: UILabel!
    @IBOutlet weak var updateDateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var interviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
