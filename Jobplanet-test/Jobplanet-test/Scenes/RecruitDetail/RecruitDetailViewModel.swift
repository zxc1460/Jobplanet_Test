//
//  RecruitDetailViewModel.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/18.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class RecruitDetailViewModel: ViewModelType {
    
    let recruit: Recruit
    private let navigator: RecruitDetailNavigatorType
    
    init(with recruit: Recruit, navigator: RecruitDetailNavigatorType) {
        self.recruit = recruit
        self.navigator = navigator
    }
    
    struct Input {
        let trigger: Driver<Void>
    }
    
    struct Output {
        let appealItems: Driver<[String]>
        let ratingItems: Driver<[Rating]>
    }
    
    func transform(input: Input) -> Output {
        let appealItems = input.trigger.flatMapLatest { _ in
            return .just(self.recruit.appeals)
        }.asDriver()
        
        let ratingItems = input.trigger.flatMapLatest { _ in
            return .just(self.recruit.company.ratings)
        }.asDriver()
        
        return Output(appealItems: appealItems, ratingItems: ratingItems)
    }
}
