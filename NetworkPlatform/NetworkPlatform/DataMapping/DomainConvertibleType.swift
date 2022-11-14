//
//  DomainConvertibleType.swift
//  NetworkPlatform
//
//  Created by Seok on 2022/11/14.
//

import Foundation

protocol DomainConvertibleType {
    associatedtype `Type`: DomainType
    
    func asDomain() -> Type
}

protocol DomainType {}


