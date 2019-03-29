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
    
    func getAllChampions(onSuccess: @escaping (ResponseModel) -> (), onFail: @escaping (NetWorkError) -> ()){
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
                    if let responseModel = try JSONDecoder().decode(ResponseModel?.self, from: data) {
                        onSuccess(responseModel)
                    }else{
                        onFail(NetWorkError.parseError)
                    }
                }catch {
                    onFail(NetWorkError.parseError)
                }
            default:
                onFail(NetWorkError.otherError)
            }
        }
    }
    
    func getChampionDetails(with id: String, onSuccess: @escaping (Champion) -> (), onFail: @escaping (NetWorkError) -> ()){
        let url = "\(STATIC_DATA_BASE_URL)/cdn/\(GAME_PATCH)/data/en_US/champion/\(id).json"
        
        let netWorkManager = NetWorkManager(URL: url, httpMethodType: .GET)
        netWorkManager.callAPI { (data, status, error) in
            guard let data = data else {
                onFail(NetWorkError.noDataError)
                return
            }
            
            switch status {
            case 200:
                do{
                    if let responseModel = try JSONDecoder().decode(ResponseModel?.self, from: data), let champion = responseModel.data["\(id)"] {
                        onSuccess(champion)
                    }else{
                        onFail(NetWorkError.parseError)
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
