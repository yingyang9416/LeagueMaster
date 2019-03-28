//
//  Champion.swift
//  LeagueMaster
//
//  Created by Ying Yang on 3/27/19.
//  Copyright © 2019 Ying Yang. All rights reserved.
//

import Foundation

struct ResonseModel: Codable {
    let type : String
    let format: String
    let data: [String: Champion]
}

struct Champion: Codable {
    let version: String
    let id: String
    let key: String
    let name: String
    let title: String
    let blurb: String
}


//struct ResonseModel: Codable {
//    let type: TypeEnum
//    let format: String
//    let version: String
//    let data: [String: Champion]
//}

//struct Champion: Codable {
//    let version: String
//    let id, key, name, title: String
//    let blurb: String
//    let info: Info
//    let image: Image
//    let tags: [Tag]
//    let partype: String
//    let stats: [String: Double]
//}

struct Image: Codable {
    let full: String
    let sprite: Sprite
    let group: TypeEnum
    let x, y, w, h: Int
}

enum TypeEnum: String, Codable {
    case champion = "champion"
}

enum Sprite: String, Codable {
    case champion0PNG = "champion0.png"
    case champion1PNG = "champion1.png"
    case champion2PNG = "champion2.png"
    case champion3PNG = "champion3.png"
    case champion4PNG = "champion4.png"
}

struct Info: Codable {
    let attack, defense, magic, difficulty: Int
}

enum Tag: String, Codable {
    case assassin = "Assassin"
    case fighter = "Fighter"
    case mage = "Mage"
    case marksman = "Marksman"
    case support = "Support"
    case tank = "Tank"
}
