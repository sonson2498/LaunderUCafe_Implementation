//
//  HomeViewModel.swift
//  Food App
//
//  Created by Balaji on 26/10/20.
//

import SwiftUI
import CoreLocation
import Firebase


// Fetching User Location....
class HomeViewModel: NSObject,ObservableObject,CLLocationManagerDelegate{
    
    @Published var locationManager = CLLocationManager()
    @Published var search = ""
    
    // Location Details....
    @Published var userLocation : CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    
    // Menu...
    @Published var showMenu = false
    
    // ItemData...
    
    @Published var items: [Item] = []
    @Published var filtered: [Item] = []
    
    // Cart Data...
    
    @Published var cartItems : [Cart] = []
    @Published var ordered = false
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    
        // checking Location Access....
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            print("unknown")
            self.noLocation = false
            // Direct Call
            locationManager.requestWhenInUseAuthorization()
            // Modifying Info.plist...
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // reading User Location And Extracting Details....
        
        self.userLocation = locations.last
        self.extractLocation()
        // after Extracting Location Logging In....
        self.login()
    }
    
    func extractLocation(){
        
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res, err) in
            
            guard let safeData = res else{return}
            
            var address = ""
            
            // getting area and locatlity name....
            
            address += safeData.first?.name ?? ""
            address += ", "
            address += safeData.first?.locality ?? ""
            
            self.userAddress = address
        }
    }
    
    // anynomus login For Reading Database....
    
    func login(){

        //let user = Auth.auth().currentUser
        //guard let uid = Auth.auth().currentUser?.uid else {return}
        
        
       /*Auth.auth().signInAnonymously { (res, err) in
            
            if err != nil{
                print(err!.localizedDescription)
                return
            }
            
            print("Success = \(res!.user.uid)")*/
            
            // After Logging in Fetching Data
            
            self.fetchData()
        //}
    }
    
    // Fetching Items Data....
    
    func fetchData(){
        
        let db = Firestore.firestore()
        
        db.collection("foodMenu").getDocuments { (snap, err) in
            
            guard let itemData = snap else{return}
            
            self.items = itemData.documents.compactMap({ (doc) -> Item? in
                
                let id = doc.documentID
                let name = doc.get("name") as! String
                let cost = doc.get("cost") as! NSNumber
                let image = doc.get("image") as! String
                let details = doc.get("details") as! String
                
                return Item(id: id, name: name, cost: cost, details: details, image: image)
            })
            
            self.filtered = self.items
        }
    }
    
    // Search or Filter...
    
    func filterData(){
        
        withAnimation(.linear){
            
            self.filtered = self.items.filter{
                return $0.name.lowercased().contains(self.search.lowercased())
            }
        }
    }
    
    // add to Cart Function....
    
    func addToCart(item: Item){
        
        // checking it is added...
        
        self.items[getIndex(item: item, isCartIndex: false)].isAdded = !item.isAdded
        // updating filtered array also for search bar results...
        
        let filterIndex = self.filtered.firstIndex { (item1) -> Bool in
            return item.id == item1.id
        } ?? 0
        
        self.filtered[filterIndex].isAdded = !item.isAdded
        
        if item.isAdded{
            
            // removing from list...
            
            self.cartItems.remove(at: getIndex(item: item, isCartIndex: true))
            return
        }
        // else adding...
        
        self.cartItems.append(Cart(item: item, quantity: 1))
    }
    
    func getIndex(item: Item,isCartIndex: Bool)->Int{
        
        let index = self.items.firstIndex { (item1) -> Bool in
            
            return item.id == item1.id
        } ?? 0
        
        let cartIndex = self.cartItems.firstIndex { (item1) -> Bool in
            
            return item.id == item1.item.id
        } ?? 0
        
        return isCartIndex ? cartIndex : index
    }
    
    
    func calculateTotalPrice()->String{
        
        var price : Float = 0
        
        cartItems.forEach { (item) in
            price += Float(item.quantity) * Float(truncating: item.item.cost)
        }
        
        return getPrice(value: price)
    }
    
    func getPrice(value: Float)->String{
        
        let format = NumberFormatter()
        format.numberStyle = .currency
        
        return format.string(from: NSNumber(value: value)) ?? ""
    }
    
    // writing Order Data into FIrestore...
    
    func updateOrder(){
        
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        
        // creating dict of food details...
        
        if ordered{
            
            ordered = false
            
            db.collection("cart").document(uid).delete { (err) in
                
                if err != nil{
                    self.ordered = true
                }
            }
            
            return
        }
        
        var details : [[String: Any]] = []
        
        cartItems.forEach { (cart) in
            
            details.append([
            
                "name": cart.item.name,
                "quantity": cart.quantity,
                "cost": cart.item.cost
            ])
        }
        
        ordered = true
        
        db.collection("cart").document(uid).setData([
            
            "ordered_food": details,
            "total_cost": calculateTotalPrice(),
            "location": GeoPoint(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            
        ]) { (err) in
            
            if err != nil{
                self.ordered = false
                return
            }
            print("success")
        }
    }
}
