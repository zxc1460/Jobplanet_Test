//
//  MainViewModel.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/16.
//

import Foundation
import Domain
import RxCocoa
import RxSwift

final class MainViewModel: ViewModelType {
    
    struct Input {
        let trigger: Driver<Void>
        let recruitTap: Driver<Void>
        let companyTap: Driver<Void>
    }
    
    struct Output {
        let selected: Driver<TabType>
    }
    
    private let navigator: MainNavigatorType
    
    init(navigator: MainNavigatorType) {
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let triggered = input.trigger.map { TabType.recruit }
        
        let recruit = input.recruitTap.map { TabType.recruit }
        
        let compnay = input.companyTap.map { TabType.company }
        
        let selected = Driver.merge(triggered, recruit, compnay)
            .distinctUntilChanged()
            .do(onNext: { type in
                switch type {
                case .recruit:
                    self.navigator.toRecruit()
                case .company:
                    self.navigator.toCompany()
                }
            })
        
        return Output(selected: selected)
    }
}
