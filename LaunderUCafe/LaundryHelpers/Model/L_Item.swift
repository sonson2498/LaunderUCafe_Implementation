//
//  L_Item.swift
//  LaunderUCafe
//
//  Created by Veridson Felissaint on 4/6/21.
//

import SwiftUI

struct L_Item: Identifiable {
    
    var id: String
    var name: String
    var cost: NSNumber
    var details: String
    var image: String
    // to identify whether it is added to cart...
    var isAdded: Bool = false
}
