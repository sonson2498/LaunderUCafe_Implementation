//
//  L_Cart.swift
//  LaunderUCafe
//
//  Created by Veridson Felissaint on 4/6/21.
//

import SwiftUI

struct L_Cart: Identifiable {
    
    var id = UUID().uuidString
    var item: L_Item
    var quantity: Int
}
