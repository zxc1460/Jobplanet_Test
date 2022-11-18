//
//  InterviewViewController.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/18.
//

import UIKit
import Kingfisher

class InterviewViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var companyView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var industryLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewView: UIView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var salaryView: UIView!
    @IBOutlet weak var interviewView: UIView!
    @IBOutlet weak var interviewLabel: UILabel!
    
    private let viewModel: InterviewViewModel
    
    init(viewModel: InterviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
    }
    
    private func setUI() {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func bindViewModel() {
        self.navigationItem.title = viewModel.interview.name
        
        if let url = URL(string: viewModel.interview.logoURL) {
            logoImageView.kf.setImage(with: url)
        }
        
        nameLabel.text = viewModel.interview.name
        industryLabel.text = viewModel.interview.industryName
        ratingLabel.text = String(format: "%.1f", viewModel.interview.averageRating)
        reviewLabel.text = viewModel.interview.reviewSummary
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        self.salaryLabel.text = formatter.string(from: NSNumber(value: viewModel.interview.averageSalary))
        
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "yyyy-MM-dd"
        dateFormmater.locale = .current
        self.dateLabel.text = dateFormmater.string(from: viewModel.interview.updateDate)
        
        interviewLabel.text = viewModel.interview.interviewQuestion
    }
}
