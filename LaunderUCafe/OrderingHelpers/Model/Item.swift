//
//  Item.swift
//  Food App
//
//  Created by Balaji on 27/10/20.
//

import SwiftUI

struct Item: Identifiable {
    
    var id: String
    var name: String
    var cost: NSNumber
    var details: String
    var image: String
    // to identify whether it is added to cart...
    var isAdded: Bool = false
}
