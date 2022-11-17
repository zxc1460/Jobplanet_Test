//
//  NetworkProvider.swift
//  NetworkPlatform
//
//  Created by DoHyeong on 2022/11/15.
//

import Domain

final class NetworkProvider {
    private let recruitEndPoint: String
    private let cellItemEndPoint: String
    
    init() {
        self.recruitEndPoint = "https://jpassets.jobplanet.co.kr/mobile-config/test_data_recruit_items.json"
        self.cellItemEndPoint = "https://jpassets.jobplanet.co.kr/mobile-config/test_data_cell_items.json"
    }
    
    func makeRecruitsNetwork() -> RecruitsNetwork {
        let network = Network<RecruitResponse>(endPoint: recruitEndPoint)
        
        return RecruitsNetwork(network: network)
    }
    
    func makeCellNetwork() -> CellNetwork {
        let network = Network<CellResponse>(endPoint: cellItemEndPoint)
        
        return CellNetwork(network: network)
    }
}
