//
//  RecruitCellViewModel.swift
//  Jobplanet-test
//
//  Created by Seok on 2022/11/16.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class RecruitCellViewModel: ViewModelType {
    struct Input {
        let select: Driver<Void>
    }
    
    struct Output {
        let selectedRecruit: Driver<Recruit>
    }
    
    let recruit: Recruit
    private let navigator: RecruitNavigatorType
    
    init(with recruit: Recruit, navigator: RecruitNavigatorType) {
        self.recruit = recruit
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let selectedRecruit = input.select
            .map {
                return self.recruit
            }
            .do(onNext: navigator.toRecruitDetail)
                
        return Output(selectedRecruit: selectedRecruit)
    }
}
