//
//  ProductDetails.swift
//  Ios Capstone Group 4
//
//  Created by user302999 on 10/1/26.
//

import SwiftUI

struct InventoryDetails:View{
    @State var grouped:[[InventoryUniqueItem]]
    var repo: any RepositoryProtocol<Inventory>
    @State private var viewModel:ViewModel
    init(inventoryUnique: InventoryUniqueItem, grouped: [[InventoryUniqueItem]], repo: any RepositoryProtocol<Inventory>) {
            self.grouped = grouped
            self.repo = repo
            self._viewModel = State(initialValue: ViewModel(inventoryUnique: inventoryUnique, userText: "", repo: repo))
        }
    var body: some View{
        
        
        
        ScrollView{
            VStack(){

                Text("\(viewModel.inventoryUnique.inventory.productName)")
                    .font(Font.largeTitle)
               
                VStack{
                    Text("Selected location: \(viewModel.inventoryUnique.inventory.locationName)")
                        .padding(8)
                        .font(Font.title2)

                
                    let targetId = viewModel.inventoryUnique.inventory.productId

                
                    HStack{
                        Text("Select a different location: " )
                        Menu{
                            if let location = grouped.first(where: { $0.first?.inventory.productId == targetId }) {
                                ForEach(location, id: \.id) { item in
                                    if(item.inventory.locationName != viewModel.inventoryUnique.inventory.locationName){
                                        
                                        NavigationLink(destination: InventoryDetails(inventoryUnique:item,grouped:grouped,repo:repo)){
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
                            
                            Divider()
                            VStack{
                                Text("Product Details:")
                                    .font(Font.title3)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 6)
                                Text("Product Id:  \(viewModel.inventoryUnique.inventory.productId)")
                                    .padding(4)
                                Text("Product Number:  \(viewModel.inventoryUnique.inventory.productNumber)")
                                    .padding(4)
                                Divider()
                                Text("Location details:")
                                    .font(Font.title3)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 6)
                                Text("location Id:  \(viewModel.inventoryUnique.inventory.locationId)")
                                    .padding(4)
                                
                                Text("shelf:  \(viewModel.inventoryUnique.inventory.shelf)")
                                    .padding(4)
                                
                                Text("bin:  \(viewModel.inventoryUnique.inventory.bin)")
                                    .padding(4)
                                
                                Divider()
                                Text("Stock Details:")
                                    .font(Font.title3)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 6)
                                Text("Quantity at location:  \(viewModel.inventoryUnique.inventory.quantity)")
                                    .padding(4)
                                
                            
                                Text("Reorder Point:  \(viewModel.inventoryUnique.inventory.reorderPoint)")
                                    .padding(4)
                                
                                
                                HStack{
                                    VStack{
                                        TextField("Add to current quantity...", text: $viewModel.userText)
                                            .textFieldStyle(.roundedBorder)
                                            .padding(10)
                                        if !viewModel.userText.isEmpty, Int(viewModel.userText) != nil{
                                            if viewModel.projectedTotal >= 0 {
                                                Text("Updated total will be: \(viewModel.projectedTotal)")
                                                    .font(Font.caption)
                                            } else {
                                                Text("Resulting quantity cannot be negative")
                                                    .font(Font.caption)
                                                    .foregroundColor(.red)
                                            }
                                        }
                                        
                                    }
                                    
                                    Button("Submit"){
                                        viewModel.updateCounts(
                                            productId: viewModel.inventoryUnique.inventory.productId,
                                            locationId: viewModel.inventoryUnique.inventory.locationId,
                                            oldQuantity: viewModel.inventoryUnique.inventory.quantity
                                        )
                                    }
                                    .padding(8)
                                    
                                    
                                }
                                
                                if let error = viewModel.errorMsg{
                                    HStack{
                                        Text(error)
                                            .font(.subheadline)
                                            .foregroundColor(Color.white)
                                            .padding(4)
                                
                                    }
                                    .background(Color.red.opacity(0.5))

                                }
                                HStack{
                                    Text("Want to order to the safety count? Try: ")
                                    Button("Quick Reorder"){
                                        viewModel.quickReorder(
                                            productId: viewModel.inventoryUnique.inventory.productId,
                                            locationId: viewModel.inventoryUnique.inventory.locationId,
                                        )
                                    
                                    }
                                }
                                if let error = viewModel.errorMsgQuickReorder{
                                    HStack{
                                        Text(error)
                                            .font(.subheadline)
                                            .foregroundColor(Color.white)
                                            .padding(4)
                                        
                                    }
                                    .background(Color.red.opacity(0.5))
                                }



                                Text("Safety Stock Level:  \(viewModel.inventoryUnique.inventory.safetyStockLevel)")
                                    .padding(8)



                            }


                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .padding(10)

                        
                    }
                }
                .background(Color.blue)
                .cornerRadius(20)
                .padding(8)
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 20)
            .background(Color.cyan)
            
            
        Spacer()
            
        }
        .frame(maxWidth: .infinity)
        .background(Color.cyan)
    }

}


extension InventoryDetails {
    
    @Observable
    class ViewModel{
        
        var inventoryUnique: InventoryUniqueItem
        var errorMsg:String? = nil
        var errorMsgQuickReorder:String? = nil

        var userText:String
        var repo: any RepositoryProtocol<Inventory>
        var projectedTotal: Int {
            let typedValue = Int(userText) ?? 0
            return inventoryUnique.inventory.quantity + typedValue
        }
        

        init(inventoryUnique: InventoryUniqueItem,userText: String,repo: any RepositoryProtocol<Inventory>) {
            self.inventoryUnique = inventoryUnique
            self.userText = userText
            self.repo = repo
        }
        
        
        //quickly reorder matching current quantity to safetyStockLvl
        func quickReorder(productId:Int, locationId:Int){
            errorMsgQuickReorder = nil
                
            let targetQuantity = inventoryUnique.inventory.safetyStockLevel
                
            guard targetQuantity > inventoryUnique.inventory.quantity else {
                errorMsgQuickReorder = "Stock is already at or above the reorder point."
                return
            }
                
            Task {
                    do {
                        try await repo.update(newCount: targetQuantity, productId: productId, locationId: locationId)
                        
                        //force a @Observable detection so state is changed meaning the new count will show up on screen
                        userText = "."
                        userText = ""
                        
                        errorMsgQuickReorder = nil
                        
                        //update the total on the screen
                        inventoryUnique.inventory.quantity = targetQuantity
                       
                        
                    } catch {
                        errorMsgQuickReorder = "There was an error updating the inventory count: \(error.localizedDescription)"
                        print(error)
                    }
                }
        }
        
        
        //add the user inputted quantity to the current quantity.
        func updateCounts(productId:Int, locationId:Int,oldQuantity:Int){
            guard let newQuantity = Int(userText) else{
                errorMsg = "please enter a valid whole number for the quantity"
                userText = ""
                return
            }
            
            guard newQuantity > 0 else{
                errorMsg = "Please enter a number greater than 0"
                userText = ""
                return
            }
            
            let finalQuantity = projectedTotal
            
            errorMsg = nil
           

            
            Task{
                do{
                    
                    try await repo.update(newCount:finalQuantity, productId: productId, locationId: locationId)
                    userText = ""
                    errorMsg = nil
                    
                    //update the total on the screen
                    inventoryUnique.inventory.quantity = finalQuantity
                    
                }catch{
                    errorMsg = "There was an error updating the inventory count: \(error.localizedDescription)"
                    print(error)
                    userText = ""

                }
            }
        }
    }
}
        
