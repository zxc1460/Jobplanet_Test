//
//  CompanyViewModel.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/17.
//

import Foundation
import Domain
import RxCocoa
import RxSwift

final class CompanyViewModel: ViewModelType {
    struct Input {
        let trigger: Driver<Void>
        let search: Driver<String>
    }
    
    struct Output {
        let fetching: Driver<Bool>
        let items: Driver<[CellViewModelType]>
        let itemIsEmpty: Driver<Bool>
    }
    
    private let useCase: CellUseCase
    private let navigator: CompanyNavigatorType
    
    init(useCase: CellUseCase, navigator: CompanyNavigatorType) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let fetchingTracker = FetchingTracker()
        
        let items = Driver.merge(input.trigger.map { String() }, input.search)
            .distinctUntilChanged()
            .trackFetchinfg(fetchingTracker)
            .flatMapLatest { keyword -> Observable<[CellViewModelType]> in
                if keyword.isEmpty {
                    return self.useCase.cells()
                        .map { cells -> [CellViewModelType] in
                            return cells.compactMap {
                                switch $0 {
                                case .interview(let interview):
                                    return InterviewCellViewModel(with: interview, navigator: self.navigator)
                                case .recruitList(let recruitList):
                                    return RecruitListViewModel(with: recruitList, navigator: self.navigator)
                                default:
                                    return nil
                                }
                            }
                        }
                } else {
                    return self.useCase.search(keyword: keyword)
                        .map { cells -> [CellViewModelType] in
                            return cells.compactMap {
                                switch $0 {
                                case .interview(let interview):
                                    return InterviewCellViewModel(with: interview, navigator: self.navigator)
                                default:
                                    return nil
                                }
                            }
                        }
                }
            }
            .asDriverOnErrorJustComplete()
        
        let fetching = fetchingTracker.asDriver()
        
        return Output(fetching: fetching, items: items, itemIsEmpty: items.map { $0.isEmpty })
    }
}
