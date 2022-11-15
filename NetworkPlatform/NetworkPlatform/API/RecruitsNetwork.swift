//
//  RecruitsNetwork.swift
//  NetworkPlatform
//
//  Created by DoHyeong on 2022/11/15.
//

import Foundation
import RxSwift

public final class RecruitsNetwork {
    private let network: Network<RecruitResponse>
    
    var cacheKey: String {
        return network.endPoint
    }
    
    init(network: Network<RecruitResponse>) {
        self.network = network
    }
    
    public func fetchRecruits() -> Observable<RecruitResponse> {
        return network.getItem()
    }
}
