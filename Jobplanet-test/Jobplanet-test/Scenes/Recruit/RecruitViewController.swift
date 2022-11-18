//
//  RecruitViewController.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/16.
//

import UIKit
import RxSwift
import RxCocoa

final class RecruitViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyView: UIView!
    
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
        
        collectionView.allowsSelection = false
    }
    
    private func bindViewModel() {
        guard let parentViewController = self.parent as? MainViewController else {
            return
        }
        
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .take(1)
            .mapToVoid()
            .asDriverOnErrorJustComplete()
            .asDriver()
        
        let search = parentViewController.searchTextField.rx.controlEvent(.editingDidEndOnExit)
            .map {
                return parentViewController.searchTextField.text
            }
            .compactMap { $0 }
            .do(onNext: { _ in parentViewController.searchTextField.resignFirstResponder() })
            .asDriverOnErrorJustComplete()
            
        
        let input = RecruitViewModel.Input(trigger: viewWillAppear, search: search)
        
        let output = viewModel.transform(input: input)
        
        output.items
            .drive(collectionView.rx.items(cellIdentifier: RecruitCell.reuseIdentifier, cellType: RecruitCell.self)) { _, viewModel, cell in
                cell.bind(viewModel)
            }
            .disposed(by: disposeBag)
        
        output.fetching
            .map { !$0 }
            .drive(parentViewController.activityIndicator.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.itemIsEmpty
            .map { !$0 }
            .drive(emptyView.rx.isHidden)
            .disposed(by: disposeBag)
    }
}
