//
//  Errors.swift
//  LeagueMaster
//
//  Created by Ying Yang on 3/27/19.
//  Copyright © 2019 Ying Yang. All rights reserved.
//

import Foundation

enum NetWorkError: Error {
    case wrongUrlError
    case noDataError
    case parseError
    case otherError
    
    var localizedDescription: String {
        switch self {
        case .wrongUrlError:
            return "Wrong URL used"
        case .noDataError:
            return "Failed to get data from web"
        case .parseError:
            return "Failed to decode data returned"
        case .otherError:
            return "Something went wrong... Please try again"
        }
    }
}
