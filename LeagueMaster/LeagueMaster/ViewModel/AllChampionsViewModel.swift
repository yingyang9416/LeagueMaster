//
//  AllChampionsViewModel.swift
//  LeagueMaster
//
//  Created by Ying Yang on 3/27/19.
//  Copyright © 2019 Ying Yang. All rights reserved.
//

import Foundation

class AllChampionsViewModel {
    private(set) var allChampions: [Champion] = []
    
    func getAllChampions(onSuccess: @escaping () -> (), onFail: @escaping (NetWorkError?)->()) {
        ApiCaller.shared.getAllChampions(onSuccess: { (responseModel) in
            for (_, champion) in responseModel.data {
                self.allChampions.append(champion)
            }
            self.allChampions = self.allChampions.sorted{ $0.name < $1.name }
            onSuccess()
        }, onFail: onFail)
    }
}
