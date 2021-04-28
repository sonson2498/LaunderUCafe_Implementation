//
//  ItemView.swift
//  Food App
//
//  Created by Balaji on 27/10/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemView: View {
    var item: Item
    var body: some View {
        
        VStack{
            
            // Downloading Image From WEb...
            
            WebImage(url: URL(string: item.image))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width - 30,height: 250)
            
            HStack(spacing: 8){
                
                Text(item.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
                
                // Deleted Ratings View....
                
            }
            
            HStack{
                
                Text(item.details)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                Spacer(minLength: 0)
            }
        }
    }
}

