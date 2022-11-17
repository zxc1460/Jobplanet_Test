//
//  InterviewCell.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/17.
//

import UIKit
import RxSwift
import RxCocoa

final class InterviewCell: UITableViewCell {
    
    static let reuseIdentifier = "InterviewCell"

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var salaryView: UIView!
    @IBOutlet weak var interviewView: UIView!
    
    @IBOutlet weak var companyIconImageView: UIImageView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var industryLabel: UILabel!
    @IBOutlet weak var updateDateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var interviewLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    private var viewModel: InterviewCellViewModel?
    private var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.disposeBag = DisposeBag()
    }
    
    func bind(_ viewModel: InterviewCellViewModel) {
        self.viewModel = viewModel
        
        if let url = URL(string: viewModel.interview.logoURL) {
            companyIconImageView.kf.setImage(with: url)
        }
        
        self.companyLabel.text = viewModel.interview.name
        self.ratingLabel.text = String(format: "%.1f", viewModel.interview.averageRating)
        self.industryLabel.text = viewModel.interview.industryName
        self.summaryLabel.text = viewModel.interview.reviewSummary
        self.interviewLabel.text = viewModel.interview.interviewQuestion
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        self.salaryLabel.text = formatter.string(from: NSNumber(value: viewModel.interview.averageSalary))
        
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "yyyy-MM-dd"
        dateFormmater.locale = .current
        self.updateDateLabel.text = dateFormmater.string(from: viewModel.interview.updateDate)
        
        
        let select = selectButton.rx.tap.asDriver()
        
        let output = viewModel.transform(input: .init(select: select))
        
        output.selectedInterview
            .drive()
            .disposed(by: disposeBag)
    }
}
