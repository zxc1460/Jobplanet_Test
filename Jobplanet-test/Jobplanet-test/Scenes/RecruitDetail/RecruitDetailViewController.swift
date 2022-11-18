//
//  RecruitDetailViewController.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/17.
//

import UIKit
import Domain
import RxSwift
import RxCocoa
import Kingfisher

final class RecruitDetailViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyView: UIView!
    @IBOutlet weak var companyLogoImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var ratingTableView: UITableView!
    @IBOutlet weak var rewardView: UIView!
    @IBOutlet weak var rewardLabel: UILabel!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    let viewModel: RecruitDetailViewModel
    private let disposebag = DisposeBag()
    
    init(viewModel: RecruitDetailViewModel) {
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.collectionViewHeight.constant = tagCollectionView.contentSize.height
        self.tableViewHeight.constant = ratingTableView.contentSize.height
    }
    
    private func setUI() {
        self.navigationController?.isNavigationBarHidden = false
        
        tagCollectionView.register(UINib(nibName: "TagCell", bundle: nil), forCellWithReuseIdentifier: TagCell.reuseIdentifier)
        ratingTableView.register(UINib(nibName: "RatingCell", bundle: nil), forCellReuseIdentifier: RatingCell.reuseIdentifier)
        
        let layout = TagCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        tagCollectionView.collectionViewLayout = layout
        tagCollectionView.allowsSelection = false
        
        ratingTableView.allowsSelection = false
        ratingTableView.rowHeight = 60
        
        imageView.kf.indicatorType = .activity
        companyLogoImageView.kf.indicatorType = .activity
        
        stackView.setCustomSpacing(5, after: companyView)
        stackView.setCustomSpacing(5, after: tagCollectionView)
    }
    
    func bindViewModel() {
        self.navigationItem.title = viewModel.recruit.title
        
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .take(1)
            .mapToVoid()
            .asDriverOnErrorJustComplete()
            .asDriver()
        
        let output = viewModel.transform(input: .init(trigger: viewWillAppear))
        
        output.appealItems
            .drive(tagCollectionView.rx.items) { collectionView, idx, appeal in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.reuseIdentifier, for: IndexPath(row: idx, section: 0)) as? TagCell else {
                    return UICollectionViewCell()
                }
                
                cell.configure(title: appeal)
                
                return cell
            }
            .disposed(by: disposebag)
        
        output.ratingItems
            .drive(ratingTableView.rx.items) { tableView, idx, rating in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: RatingCell.reuseIdentifier) as? RatingCell else {
                    return UITableViewCell()
                }
                
                cell.bind(rating)
                
                return cell
            }
            .disposed(by: disposebag)
        
        if let url = URL(string: viewModel.recruit.imageURL) {
            self.imageView.kf.setImage(with: url)
        }
        
        if let url = URL(string: viewModel.recruit.company.logoURL) {
            self.companyLogoImageView.kf.setImage(with: url)
        }
        
        self.titleLabel.text = viewModel.recruit.title
        self.companyNameLabel.text = viewModel.recruit.company.name
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        self.rewardLabel.text = "축하금: \(formatter.string(from: NSNumber(value: viewModel.recruit.reward)) ?? "")원"
        
        self.rewardView.isHidden = viewModel.recruit.reward == .zero
    }
}
