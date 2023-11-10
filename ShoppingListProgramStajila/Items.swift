//
//  Items.swift
//  ShoppingListProgramStajila
//
//  Created by Stanislav Stajila on 11/8/23.
//

import Foundation
class Items: Codable{
    var name: String
    var checkStatus: Bool
    
    init(name: String, checkStatus: Bool) {
        self.name = name
        self.checkStatus = checkStatus
    }
}
