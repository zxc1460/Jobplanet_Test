//
//  CompanyViewController.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/17.
//

import UIKit
import RxSwift
import RxCocoa

final class CompanyViewController: UIViewController {
    
    @IBOutlet weak var emptyView: UIView!
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

        setUI()
        bindViewModel()
    }
    
    private func setUI() {
        self.tableView.separatorColor = .jpGray03
        self.tableView.separatorInset = .zero
        self.tableView.estimatedRowHeight = 400
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.allowsSelection = false
        self.tableView.register(UINib(nibName: "InterviewCell", bundle: nil), forCellReuseIdentifier: InterviewCell.reuseIdentifier)
        self.tableView.register(UINib(nibName: "RecruitListCell", bundle: nil), forCellReuseIdentifier: RecruitListCell.reuseIdentifier)
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
            .drive(tableView.rx.items) { tableView, idx, cellViewModel in
                if let cellViewModel = cellViewModel as? InterviewCellViewModel,
                    let cell = tableView.dequeueReusableCell(withIdentifier: InterviewCell.reuseIdentifier) as? InterviewCell {
                        
                    cell.bind(cellViewModel)
                        
                    return cell
                } else if let cellViewModel = cellViewModel as? RecruitListViewModel,
                          let cell = tableView.dequeueReusableCell(withIdentifier: RecruitListCell.reuseIdentifier) as? RecruitListCell {
                    
                    cell.bind(cellViewModel)
                    
                    return cell
                }
                    
                return UITableViewCell()
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
