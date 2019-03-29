//
//  Champion.swift
//  LeagueMaster
//
//  Created by Ying Yang on 3/27/19.
//  Copyright © 2019 Ying Yang. All rights reserved.
//

import Foundation

//struct ResonseModel: Codable {
//    let type : String
//    let format: String
//    let data: [String: Champion]
//}
//
//struct Champion: Codable {
//    let version: String
//    let id: String
//    let key: String
//    let name: String
//    let title: String
//    let blurb: String
//}


struct ResponseModel: Codable {
    let type, format, version: String
    let data: [String: Champion]
}

struct Champion: Codable {
    let id, key, name, title, blurb, partype: String
    let info: Info
    let image: Image
    let tags: [String]
    let stats: [String: Double]
    let version, lore: String?
    let allytips, enemytips: [String]?
    let skins: [Skin]?
    let spells: [Spell]?
    let passive: Passive?
}

struct Image: Codable {
    let full: String
    let sprite: String
    let group: String
    let x, y, w, h: Int
}

struct Info: Codable {
    let attack, defense, magic, difficulty: Int
}

struct Skin: Codable {
    let id: String
    let num: Int
    let name: String
    let chromas: Bool
}

struct Spell: Codable {
    let id, name, description, tooltip: String
    let leveltip: Leveltip
    let maxrank: Int
    let cooldownBurn: String
    let cost: [Int]
    let costBurn: String
    let effect: [[Double]?]
    let effectBurn: [String?]
    let vars: [Var]
    let costType, maxammo: String
    let range: [Int]
    let rangeBurn: String
    let image: Image
    let resource: String
}

struct Passive: Codable {
    let name, description: String
    let image: Image
}

struct Leveltip: Codable {
    let label, effect: [String]
}

struct Var: Codable {
    let link: String
    let key: String
}

//enum Tag: String, Codable {
//    case assassin = "Assassin"
//    case fighter = "Fighter"
//    case mage = "Mage"
//    case marksman = "Marksman"
//    case support = "Support"
//    case tank = "Tank"
//}
