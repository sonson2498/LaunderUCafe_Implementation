//
//  Home.swift
//  Firebase Tutorial
//
//  Created by Kavsoft on 05/01/20.
//  Copyright © 2020 Kavsoft. All rights reserved.
//

import SwiftUI
/*
struct Home : View {
    
    //@EnvironmentObject var categories : getCategoriesData
    @ObservedObject var categories = getCategoriesData()
    
    var body : some View{
        
        VStack{
            
            if self.categories.datas.count != 0{
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 15){
                        
                        ForEach(self.categories.datas){i in
                            
                            CellView(data: i)
                        }
                        
                    }.padding()
                    
                }.background(Color("Color").edgesIgnoringSafeArea(.all))
            }
            
            else{
                
                Loader()
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
*/



struct Home: View {
    
    @StateObject var HomeModel = HomeViewModel()
    
    var body: some View {
        
        ZStack{
            
            VStack(spacing: 10){
                
                HStack(spacing: 15){
                    

                    Button(action: {
                        withAnimation(.easeIn){HomeModel.showMenu.toggle()}
                    }, label: {
                        
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(Color.purple)
                    })
                    
                    /*Text(HomeModel.userLocation == nil ? "Locating..." : "Deliver To")
                        .foregroundColor(.black)
                    
                    Text(HomeModel.userAddress)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(.purple)*/
                    
                    Spacer(minLength: 0)
                }
                .padding([.horizontal,.top])
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $HomeModel.search)
                    
                }
                .padding(.horizontal)
                .padding(.top,10)
                
                Divider()
                
                if HomeModel.items.isEmpty{
                    
                    Spacer()
                    
                    ProgressView()
                    
                    Spacer()
                }
                else{
                    
                    ScrollView(.vertical, showsIndicators: false, content: {
                        
                        VStack(spacing: 25){
                            
                            ForEach(HomeModel.filtered){item in
                                
                                // Item View...
                                
                                ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                                    
                                    ItemView(item: item)
                                    
                                    HStack{
                                        
                                        Text("Pick up Only")
                                            .foregroundColor(.white)
                                            .padding(.vertical,10)
                                            .padding(.horizontal)
                                            .background(Color.purple)
                                        
                                        Spacer(minLength: 0)
                                        
                                        Button(action: {
                                           HomeModel.addToCart(item: item)
                                        }, label: {
                                            
                                            Image(systemName: item.isAdded ? "checkmark" : "plus")
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .background(item.isAdded ? Color.green : Color.purple)
                                                .clipShape(Circle())
                                        })
                                    }
                                    .padding(.trailing,10)
                                    .padding(.top,10)
                                        
                                })
                                .frame(width: UIScreen.main.bounds.width - 30)
                            }
                        }
                        .padding(.top,10)
                    })
                }
            }
            
            // Side Menu.....
            
            HStack{
                
                Menu(homeData: HomeModel)
                    // Move Effect From Left....
                    .offset(x: HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.6)
                
                Spacer(minLength: 0)
            }
            .background(
                Color.black.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea()
                // clsing when Taps on outside...
                    .onTapGesture(perform: {
                        withAnimation(.easeIn){HomeModel.showMenu.toggle()}
                    })
            )
            
            // Non CLosable ALert If Permission Denied....
            
            if HomeModel.noLocation{
                
                Text("Please Enable Location Access In Settings To Further Move On !!!")
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 100, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
            }
        }
        .onAppear(perform: {
            
            // calling location delegate....
            HomeModel.locationManager.delegate = HomeModel
        })
        .onChange(of: HomeModel.search, perform: { value in
            
            // to avoid Continues Search requests....
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                
                if value == HomeModel.search && HomeModel.search != ""{
                    
                    // Search Data....
                    
                    HomeModel.filterData()
                }
            }
            
            if HomeModel.search == ""{
                // reset all data....
                withAnimation(.linear){HomeModel.filtered = HomeModel.items}
            }
        })
    }
}

