//
//  LaundryVC.swift
//  LaunderUCafe
//
//  Created by Veridson Felissaint on 3/30/21.
//

import SwiftUI

struct LaundryVC: View {
    var body: some View {

        NavigationView{
            
            L_Home()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
    }
}

struct LaundryVC_Preview: PreviewProvider {
    static var previews: some View {
        LaundryVC()
    }
}
