//
//  MainViewController.swift
//  Jobplanet-test
//
//  Created by Seok on 2022/11/15.
//

import UIKit
import RxCocoa
import RxSwift

enum TabType {
    case recruit
    case company
}

class MainViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var recruitButton: HighlightedButton!
    @IBOutlet weak var companyButon: HighlightedButton!
    @IBOutlet weak var contaierView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var childViewController: UIViewController?
    
    var viewModel: MainViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setUI() {
        recruitButton.setTitleColor(.jpGray01, for: .normal)
        recruitButton.setTitleColor(.white, for: .selected)
        companyButon.setTitleColor(.jpGray01, for: .normal)
        companyButon.setTitleColor(.white, for: .selected)
        
        activityIndicator.startAnimating()
    }
    
    private func bindViewModel() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .take(1)
            .mapToVoid()
            .asDriverOnErrorJustComplete()
            .asDriver()
                
        let recruitTap = recruitButton.rx.tap.asDriverOnErrorJustComplete()
                
        
        let companyTap = companyButon.rx.tap.asDriverOnErrorJustComplete()
        
        let input = MainViewModel.Input(trigger: viewWillAppear, recruitTap: recruitTap, companyTap: companyTap)
        
        let output = viewModel.transform(input: input)
        
        output.selected
            .do(onNext: {
                self.highlightButton($0)
                self.searchTextField.text = ""
            })
            .drive()
            .disposed(by: disposeBag)
    }
    
    private func highlightButton(_ tabType: TabType) {
        self.recruitButton.isSelected = tabType == .recruit
        self.companyButon.isSelected = tabType == .company
    }
}
