//
//  Laundry.swift
//  LaunderUCafe
//
//  Created by Veridson Felissaint on 4/6/21.
//

import SwiftUI

struct Laundry: View {
    @ObservedObject var homeData : L_HomeViewModel
    var body: some View {
        
        VStack{
            
            NavigationLink(destination: L_CartView(homeData: homeData)) {
                
                HStack(spacing: 15){
                    
                    Image(systemName: "cart")
                        .font(.title)
                        .foregroundColor(Color.purple)
                    
                    Text("Cart")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                }
                .padding()
            }
            
            Spacer()
            
            HStack{
                
                Spacer()
                
                Text("LaunderUCafe")
                    .fontWeight(.bold)
                    .foregroundColor(Color.purple)
            }
            .padding(10)
        }
        .padding([.top,.trailing])
        .frame(width: UIScreen.main.bounds.width / 1.6)
        .background(Color.white.ignoresSafeArea())
    }
}


