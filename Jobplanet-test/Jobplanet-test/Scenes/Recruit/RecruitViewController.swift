//
//  RecruitViewController.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/16.
//

import UIKit
import RxSwift
import RxCocoa

class RecruitViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel: RecruitViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: RecruitViewModel) {
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
        let itemSpacing: CGFloat = 15
        let horizontalInset: CGFloat = 20
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 8, left: horizontalInset, bottom: 8, right: horizontalInset)
        layout.minimumInteritemSpacing = itemSpacing
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(
            width: (collectionView.frame.width - itemSpacing - (horizontalInset * 2)) / 2,
            height: 226
        )
        layout.scrollDirection = .vertical
        
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "RecruitCell", bundle: nil), forCellWithReuseIdentifier: RecruitCell.reuseIdentifier)
    }
    
    private func bindViewModel() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
            .asDriver()
        
        let input = RecruitViewModel.Input(trigger: viewWillAppear)
        
        let output = viewModel.transform(input: input)
        
        output.items
            .drive(collectionView.rx.items(cellIdentifier: RecruitCell.reuseIdentifier, cellType: RecruitCell.self)) { _, viewModel, cell in
                cell.bind(viewModel)
            }
            .disposed(by: disposeBag)
        
    }
}
