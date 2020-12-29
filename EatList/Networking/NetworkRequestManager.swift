//
//  NetworkRequestManager.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation
import Moya
import Alamofire

typealias RequestSuccessBlock = (Response) -> Void
typealias RequestFailedBlock = (EatListError) -> Void

class NetworkRequestManager {
    /// For centralized network fetch error handling.
    /// Should we wish to add other possible errors in the future that all other APIs will likely have, e.g., server maintenance, we put the handling here.
    static func fetchData<T: TargetType>(
        target: T,
        provider: MoyaProvider<T>,
        onSuccess: @escaping RequestSuccessBlock,
        onFailure: @escaping RequestFailedBlock
    ) {
        provider.request(target) { result in
            switch result {
            case .success(let response): onSuccess(response)
            case .failure(let error):
                switch error {
                case .underlying(Alamofire.AFError.explicitlyCancelled, _): break
                default: onFailure(EatListError.networkConnectivity)
                }
            }
        }
    }
    
}
