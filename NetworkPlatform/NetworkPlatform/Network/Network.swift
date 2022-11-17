//
//  Network.swift
//  NetworkPlatform
//
//  Created by DoHyeong on 2022/11/15.
//

import Foundation
import Domain
import Alamofire
import RxAlamofire
import RxSwift

final class Network<T: Decodable> {
    let endPoint: String
    private let scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: .background, relativePriority: 1))
    
    init(endPoint: String) {
        self.endPoint = endPoint
    }
    
    func getItems(path: String? = nil) -> Observable<[T]> {
        var absolutePath = endPoint
        
        if let path = path {
            absolutePath += "/\(path)"
        }
        
        return RxAlamofire
            .data(.get, absolutePath)
            .debug()
            .observe(on: scheduler)
            .map { data -> [T] in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                return try decoder.decode([T].self, from: data)
            }
    }
    
    
    func getItem(path: String? = nil) -> Observable<T> {
        var absolutePath = endPoint
        
        if let path = path {
            absolutePath += "/\(path)"
        }
        
        return RxAlamofire
            .data(.get, absolutePath)
            .observe(on: scheduler)
            .map { data -> T in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .custom(CustomDateDecodingStrategy.decode)
                
                return try decoder.decode(T.self, from: data)
            }
    }
}
