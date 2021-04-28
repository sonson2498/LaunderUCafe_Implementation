//
//  Menu.swift
//  Food App
//
//  Created by Balaji on 26/10/20.
//

import SwiftUI

struct Menu: View {
    @ObservedObject var homeData : HomeViewModel
    var body: some View {
        
        VStack{
            
            NavigationLink(destination: CartView(homeData: homeData)) {
                
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

