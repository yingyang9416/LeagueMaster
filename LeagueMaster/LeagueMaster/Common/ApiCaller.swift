//
//  ApiCaller.swift
//  LeagueMaster
//
//  Created by Ying Yang on 3/27/19.
//  Copyright © 2019 Ying Yang. All rights reserved.
//

import Foundation

class ApiCaller {
    static let shared = ApiCaller()
    
    func getAllChampions(onSuccess: @escaping (ResonseModel) -> (), onFail: @escaping (NetWorkError) -> ()){
        let url = "\(STATIC_DATA_BASE_URL)/cdn/\(GAME_PATCH)/data/en_US/champion.json"
        
        let netWorkManager = NetWorkManager(URL: url, httpMethodType: .GET)
        netWorkManager.callAPI { (data, status, error) in
            guard let data = data else {
                onFail(NetWorkError.noDataError)
                return
            }
            
            switch status {
            case 200:
                do{
                    if let responseModel = try JSONDecoder().decode(ResonseModel?.self, from: data) {
                        onSuccess(responseModel)
                    }
                }catch {
                    onFail(NetWorkError.parseError)
                }
            default:
                onFail(NetWorkError.otherError)
            }
        }
    }
    
}
