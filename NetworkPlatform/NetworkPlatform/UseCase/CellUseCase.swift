//
//  CellUseCase.swift
//  NetworkPlatform
//
//  Created by DoHyeong on 2022/11/17.
//

import Foundation
import Domain
import RxSwift

final class CellUseCase<Cache>: Domain.CellUseCase where Cache: Caching, Cache.ValueType == CellResponse, Cache.KeyType == String {
    private let network: CellNetwork
    private let cache: Cache
    
    init(network: CellNetwork, cache: Cache) {
        self.network = network
        self.cache = cache
    }
    
    func cells() -> Observable<[CellType]> {
        return cache.fetch(key: network.cacheKey).asObservable()
            .debug()
            .flatMap { response -> Observable<[CellType]> in
                if let response = response {
                    return Observable.just(response.cellItems.map { $0.asDomain() })
                } else {
                    return self.network.fetchCell()
                        .flatMap { response in
                            self.cache.save(key: self.network.cacheKey, value: response)
                                .debug()
                                .asObservable()
                                .flatMap { _ in
                                    return Observable.just(response)
                                        .map {
                                            return $0.cellItems
                                                .filter {
                                                    switch $0 {
                                                    case .review:
                                                        return false
                                                    default:
                                                        return true
                                                    }
                                                }
                                                .map { $0.asDomain() }
                                        }
                                }
                        }
                }
            }
    }
    
    func search(keyword: String) -> Observable<[CellType]> {
        let keyword = keyword.lowercased().replacingOccurrences(of: " ", with: "")
        
        return cells()
            .map { cells in
                return cells.filter { cell in
                    switch cell {
                    case .recruitList, .review:
                        return false
                    case .interview(let interview):
                        return interview.name.lowercased().replacingOccurrences(of: " ", with: "").contains(keyword)
                    }
                }
            }
    }
}
