//
//  RecruitsUseCase.swift
//  NetworkPlatform
//
//  Created by DoHyeong on 2022/11/15.
//

import Foundation
import Domain
import RxSwift

final class RecruitUseCase<Cache>: Domain.RecruitUseCase where Cache: Caching, Cache.ValueType == RecruitResponse, Cache.KeyType == String {
    private let network: RecruitsNetwork
    private let cache: Cache
    
    init(network: RecruitsNetwork, cache: Cache) {
        self.network = network
        self.cache = cache
    }
    
    func recruits() -> Observable<[Recruit]> {
        return cache.fetch(key: network.cacheKey).asObservable()
            .debug()
            .flatMap { response -> Observable<[Recruit]> in
                if let response = response {
                    return Observable.just(response.recruitItems.map { $0.asDomain() })
                } else {
                    return self.network.fetchRecruits()
                        .flatMap { response in
                            self.cache.save(key: self.network.cacheKey, value: response)
                                .debug()
                                .asObservable()
                                .flatMap { _ in
                                    return Observable.just(response)
                                        .map {
                                            return $0.recruitItems.map { $0.asDomain() }
                                        }
                                }
                        }
                }
            }
    }
    
    func search(keyword: String) -> Observable<[Recruit]> {
        return recruits()
            .map { recruits in
                return recruits.filter { $0.title == keyword }
            }
    }
}
