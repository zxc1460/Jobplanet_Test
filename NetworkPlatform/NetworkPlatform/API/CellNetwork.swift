//
//  CellNetwork.swift
//  NetworkPlatform
//
//  Created by DoHyeong on 2022/11/17.
//

import Foundation
import RxSwift

public final class CellNetwork {
    private let network: Network<CellResponse>
    
    var cacheKey: String {
        return network.endPoint
    }
    
    init(network: Network<CellResponse>) {
        self.network = network
    }
    
    public func fetchCell() -> Observable<CellResponse> {
        return network.getItem()
    }
}
