//
//  RecruitCell.swift
//  Jobplanet-test
//
//  Created by Seok on 2022/11/16.
//

import Foundation
import UIKit
import Kingfisher
import RxSwift

final class RecruitCell: UICollectionViewCell {
    
    static let reuseIdentifier = "RecruitCell"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    private var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    private var viewModel: RecruitCellViewModel?
    
    private func setUI() {
        let layout = TagCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        layout.sectionInset = .zero
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        tagCollectionView.collectionViewLayout = layout
        tagCollectionView.register(UINib(nibName: "TagCell", bundle: nil), forCellWithReuseIdentifier: TagCell.reuseIdentifier)
        
        imageView.kf.indicatorType = .activity
    }
    
    func bind(_ viewModel: RecruitCellViewModel) {
        self.viewModel = viewModel
        
        if let url = URL(string: viewModel.recruit.imageURL) {
        
            imageView.kf.setImage(with: url)
        }
        
        self.titleLabel.text = viewModel.recruit.title
        self.ratingLabel.text = String(format: "%.1f", viewModel.recruit.highestRating)
        self.companyLabel.text = viewModel.recruit.company.name
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        self.rewardLabel.text = "축하금: \(formatter.string(from: NSNumber(value: viewModel.recruit.reward)) ?? "")원"
        
        self.rewardLabel.isHidden = viewModel.recruit.reward == 0
        self.tagCollectionView.isHidden = viewModel.recruit.appeals.isEmpty
        
        tagCollectionView.reloadData()
        
        let select = selectButton.rx.tap.asDriver()
        
        let output = viewModel.transform(input: .init(select: select))
        
        output.selectedRecruit
            .drive()
            .disposed(by: disposeBag)
        
        output.appealItems
            .drive(tagCollectionView.rx.items) { collectionView, idx, appeal in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.reuseIdentifier, for: IndexPath(row: idx, section: 0)) as? TagCell else {
                    return UICollectionViewCell()
                }
                
                cell.configure(title: appeal)
                
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.disposeBag = DisposeBag()
    }
}
