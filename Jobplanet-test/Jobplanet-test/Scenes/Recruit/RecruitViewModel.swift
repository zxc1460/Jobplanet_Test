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
        let search: Driver<String>
    }
    
    struct Output {
        let fetching: Driver<Bool>
        let items: Driver<[RecruitCellViewModel]>
        let itemIsEmpty: Driver<Bool>
    }
    
    private let useCase: RecruitUseCase
    private let navigator: RecruitNavigatorType
    
    init(useCase: RecruitUseCase, navigator: RecruitNavigatorType) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let fetchingTracker = FetchingTracker()
        
        let items = Driver.merge(input.trigger.map { String() }, input.search)
            .distinctUntilChanged()
            .trackFetchinfg(fetchingTracker)
            .flatMapLatest { keyword -> Observable<[RecruitCellViewModel]> in
                if keyword.isEmpty {
                    return self.useCase.recruits()
                        .map { recruits -> [RecruitCellViewModel] in
                            return recruits.map { .init(with: $0, navigator: self.navigator) }
                        }
                } else {
                    return self.useCase.search(keyword: keyword)
                        .map { recruits -> [RecruitCellViewModel] in
                            return recruits.map { .init(with: $0, navigator: self.navigator) }
                        }
                }
            }
            .asDriverOnErrorJustComplete()
            
        
        let fetching = fetchingTracker.asDriver()
        
        return Output(fetching: fetching, items: items, itemIsEmpty: items.map { $0.isEmpty })
    }
}
