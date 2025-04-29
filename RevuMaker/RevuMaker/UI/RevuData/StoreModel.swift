//
//  StoreModel.swift
//  RevuMaker
//
//  Created by 김도연 on 4/29/25.
//

import Foundation

struct StoreModel: Hashable {
    let storeName: String
    let category: String
    let productNames: [String]
}

enum ConfirmMode {
    case fromScan
    case fromEmpty
}
