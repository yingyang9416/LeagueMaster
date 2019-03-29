//
//  ChampionDetailViewModel.swift
//  LeagueMaster
//
//  Created by Ying Yang on 3/28/19.
//  Copyright © 2019 Ying Yang. All rights reserved.
//

import Foundation

class ChampionDetailsViewModel {
    private(set) var champion: Champion?
    
    func getChampionDetails(with id: String, onSuccess: @escaping () -> (), onFail: @escaping (NetWorkError?)->()) {
        ApiCaller.shared.getChampionDetails(with: id, onSuccess: { (champ) in
            self.champion = champ
            onSuccess()
        }, onFail: onFail)

    }
    
}
