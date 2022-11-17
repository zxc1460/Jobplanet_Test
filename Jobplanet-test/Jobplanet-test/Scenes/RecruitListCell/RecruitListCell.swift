//
//  RecruitListCell.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/17.
//

import UIKit
import RxSwift
import RxCocoa

final class RecruitListCell: UITableViewCell {
    
    static let reuseIdentifier = "RecruitListCell"
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel: RecruitListViewModel?
    private var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.disposeBag = DisposeBag()
    }
    
    private func setUI() {
        collectionView.register(UINib(nibName: "RecruitCell", bundle: nil), forCellWithReuseIdentifier: RecruitCell.reuseIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.itemSize = CGSize(width: 160, height: collectionView.frame.height)
        layout.minimumInteritemSpacing  = 12
        layout.scrollDirection = .horizontal
        
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func bind(_ viewModel: RecruitListViewModel) {
        self.viewModel = viewModel
        
        self.titleLabel.text = viewModel.recruitList.sectionTitle
        
        let output = viewModel.transform(input: RecruitListViewModel.Input())
        
        output.items
            .drive(collectionView.rx.items(cellIdentifier: RecruitCell.reuseIdentifier, cellType: RecruitCell.self)) { _, viewModel, cell in
                cell.bind(viewModel)
            }
            .disposed(by: disposeBag)
    }

}
