//
//  L_ItemView.swift
//  LaunderUCafe
//
//  Created by Veridson Felissaint on 4/6/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct L_ItemView: View {
    var item: L_Item
    var body: some View {
        
        VStack{
            
            // Downloading Image From WEb...
            
            WebImage(url: URL(string: item.image))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width - 250, height: 130)
                .cornerRadius(15)
                //.resizable()
                //.aspectRatio(contentMode: .fill)
                //.frame(width: UIScreen.main.bounds.width - 30,height: 250)
            
            //use to be HStack without the alignment
            VStack(alignment: .leading, spacing: 8){
                
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
