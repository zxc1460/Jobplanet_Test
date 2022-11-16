//
//  RecruitViewModel.swift
//  Jobplanet-test
//
//  Created by Seok on 2022/11/17.
//

import Foundation
import Domain
import RxCocoa
import RxSwift

final class RecruitViewModel: ViewModelType {
    struct Input {
        let trigger: Driver<Void>
    }
    
    struct Output {
        let items: Driver<[RecruitCellViewModel]>
    }
    
    private let useCase: RecruitUseCase
    private let navigator: RecruitNavigatorType
    
    init(useCase: RecruitUseCase, navigator: RecruitNavigatorType) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let items = input.trigger.flatMapLatest { _ in
            return self.useCase.recruits()
                .asDriverOnErrorJustComplete()
                .map { recruits -> [RecruitCellViewModel] in
                    return recruits.map { .init(with: $0) }
                }
        }
        
        return Output(items: items)
    }
}
