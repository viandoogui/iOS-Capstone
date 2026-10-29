//
//  ProductDetails.swift
//  Ios Capstone Group 4
//
//  Created by user302999 on 10/1/26.
//

import SwiftUI

struct InventoryDetails:View{
    @State  var inventoryUnique:InventoryUniqueItem
    @State var grouped:[[InventoryUniqueItem]]
    
    
    var body: some View{
        
        
        
        ScrollView{
            VStack(){
//                HStack(){
//                    Text("Home Button")
//                        .padding(12)
//                }
                Text("\(inventoryUnique.inventory.productName)")
                    .font(Font.largeTitle)
               
                VStack{
                Text("Selected location: \(inventoryUnique.inventory.locationName)")
                        .padding(8)
                        .font(Font.title2)

                
                let targetId = inventoryUnique.inventory.productId

                
                    HStack{
                        Text("Select a different location: " )
                        Menu{
                            if let location = grouped.first(where: { $0.first?.inventory.productId == targetId }) {
                                ForEach(location, id: \.id) { item in
                                    if(item.inventory.locationName != inventoryUnique.inventory.locationName){
                                        
                                        NavigationLink(destination: InventoryDetails(inventoryUnique:item,grouped:grouped)){
                                            Text("\(item.inventory.locationName), Quantity: \(item.inventory.quantity)")
                                                .bold()
                                        }
                                        Divider()
                                    }
                                }
                            }
                            
                        }label:{
                            Text("Locations")
                                .underline()
                                .bold()
                        }
                    }
                    .padding(8)
                    .font(Font.title3)

                }
                .background(Color.white)
                .padding(16)
              
                VStack(){


                    VStack(){
                        
                        VStack(){

//                            VStack{
//                                HStack{
//                                    Text("Inventory for:  ")
//                                        .font(Font.headline)
//                                    Text("\(inventoryUnique.inventory.productName)")
//                                        .font(Font.headline)
//                                        .underline()
//                                }
//                                HStack{
//                                    Text(" at location: ")
//                                        .font(Font.headline)
//                                    
//                                    Text("\(inventoryUnique.inventory.locationName)")
//                                        .font(Font.headline)
//                                        .underline()
//                                }
//                            }
                            
                            Divider()
                            VStack{
                                Text("Product Details:")
                                    .font(Font.title3)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 6)
                                Text("Product Id:  \(inventoryUnique.inventory.productId)")
                                    .padding(4)
                                Text("Product Number:  \(inventoryUnique.inventory.productNumber)")
                                    .padding(4)
                                Divider()
                                Text("Location details:")
                                    .font(Font.title3)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 6)
                                Text("location Id:  \(inventoryUnique.inventory.locationId)")
                                    .padding(4)

                                Text("shelf:  \(inventoryUnique.inventory.shelf)")
                                    .padding(4)

                                Text("bin:  \(inventoryUnique.inventory.bin)")
                                    .padding(4)

                                Divider()
                                Text("Stock Details:")
                                    .font(Font.title3)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 6)
                                Text("Quantity at location:  \(inventoryUnique.inventory.quantity)")
                                    .padding(4)

                                Text("Reorder Point:  \(inventoryUnique.inventory.reorderPoint)")
                                    .padding(4)

                                Text("Safety Stock Level:  \(inventoryUnique.inventory.safetyStockLevel)")
                                    .padding(8)



                            }






                            
                       
                            

                        }
                        .frame(maxWidth: .infinity) //ensure horizontal center
                        .background(Color.white)
                        .padding(10)

                        
                    }
                }
                .background(Color.blue)
                .cornerRadius(20)
                .padding(8)
                .frame(maxWidth: .infinity) //ensure horizontal center

            }
            .frame(maxWidth: .infinity) //ensure horizontal center
            .padding(.top, 20)
            .background(Color.cyan)
            
            
        Spacer()
            
        }
        .frame(maxWidth: .infinity) //ensure horizontal center
        .background(Color.cyan)
        //.padding(10)
    }

}

