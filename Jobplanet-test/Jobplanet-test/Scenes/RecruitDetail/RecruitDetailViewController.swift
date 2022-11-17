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

final class RecruitDetailViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setUI() {
        tagCollectionView.register(UINib(nibName: "TagCell", bundle: nil), forCellWithReuseIdentifier: TagCell.reuseIdentifier)
        ratingTableView.register(UINib(nibName: "RatingCell", bundle: nil), forCellReuseIdentifier: RatingCell.reuseIdentifier)
        
        let layout = TagCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        
        tagCollectionView.collectionViewLayout = layout
        tagCollectionView.allowsSelection = false
        
        ratingTableView.allowsSelection = false
        ratingTableView.rowHeight = 70
    }
}
