//
//  CompanyViewController.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/17.
//

import UIKit
import RxSwift
import RxCocoa

class CompanyViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: CompanyViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: CompanyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }
    
    private func bindViewModel() {
        guard let parentViewController = self.parent as? MainViewController else {
            return
        }
        
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
            .asDriver()
        
        let search = parentViewController.searchTextField.rx.controlEvent(.editingDidEndOnExit)
            .map { return parentViewController.searchTextField.text }
            .compactMap { $0 }
            .do(onNext: { _ in parentViewController.searchTextField.resignFirstResponder() })
            .asDriverOnErrorJustComplete()
                
                
        let input = CompanyViewModel.Input(trigger: viewWillAppear, search: search)
                
        let output = viewModel.transform(input: input)
        
        output.items
            .drive()
            .disposed(by: disposeBag)
                
        output.fetching
            .map { !$0 }
            .drive()
            .disposed(by: disposeBag)
                
        output.itemIsEmpty
            .map { !$0 }
            .drive()
            .disposed(by: disposeBag)
    }
}
