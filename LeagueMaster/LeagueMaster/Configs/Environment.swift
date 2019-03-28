//
//  Environment.swift
//  LeagueMaster
//
//  Created by Ying Yang on 3/27/19.
//  Copyright © 2019 Ying Yang. All rights reserved.
//

import Foundation

public enum PlistKey {
    case ServerBaseURL
    case StaticDataBaseURL
    case GamePatch
    case ApiKey
    
    func value() -> String {
        switch self {
        case .ServerBaseURL:
            return "server_base_url"
        case .StaticDataBaseURL:
            return "static_data_base_url"
        case .GamePatch:
            return "game_patch"
        case .ApiKey:
            return "api_key"
        }
    }
}

public struct Environment {
    
    fileprivate static var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }else {
                fatalError("Plist file not found")
            }
        }
    }
    
    public static func configuration(_ key: PlistKey) -> String {
        switch key {
        case .ServerBaseURL:
            return infoDict[PlistKey.ServerBaseURL.value()] as! String
        case .StaticDataBaseURL:
            return infoDict[PlistKey.StaticDataBaseURL.value()] as! String
        case .GamePatch:
            return infoDict[PlistKey.GamePatch.value()] as! String
        case .ApiKey:
            return infoDict[PlistKey.ApiKey.value()] as! String
        }
    }
}

