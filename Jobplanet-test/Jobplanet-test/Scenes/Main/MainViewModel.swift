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
        let highlighted: Driver<TabType>
    }
    
    private let navigator: MainNavigatorType
    
    init(navigator: MainNavigatorType) {
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let triggered = input.trigger.do(onNext: { self.navigator.toRecruit() } ).map { TabType.recruit }
        
        let recruit = input.recruitTap.do(onNext: { self.navigator.toRecruit() } ).map { TabType.recruit }
        
        let compnay = input.companyTap.do(onNext: { self.navigator.toCompany() } ).map { TabType.company }
        
        return Output(
            highlighted: Driver.merge(triggered, recruit, compnay).distinctUntilChanged()
        )
    }
}
