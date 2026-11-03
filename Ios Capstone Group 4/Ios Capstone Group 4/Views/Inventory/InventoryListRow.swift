//
//  ProductListRow.swift
//  Ios Capstone Group 4
//
//  Created by user302999 on 10/15/26.
//

import SwiftUI
struct InventoryListRow:View {
    
        var inv:[InventoryUniqueItem]
        var grouped:[[InventoryUniqueItem]]
        var repo: any RepositoryProtocol<Inventory>
    init(inv:[InventoryUniqueItem],grouped:[[InventoryUniqueItem]], repo: any RepositoryProtocol<Inventory>) {
            self.inv = inv
        self.grouped = grouped
        self.repo = repo
        }
    
    var body: some View {
        
        DisclosureGroup{
            VStack(spacing: 4) {
                ForEach(inv, id:\.self){item in
                    NavigationLink(destination:InventoryDetails(inventoryUnique:item,grouped:grouped, repo:repo)){
                        HStack{
                            Spacer()
                            
                            Text("Location: \(item.inventory.locationName)")
                                .padding(4)
                            
                            Spacer()
                            VStack{
                                Text("Quantity: \(item.inventory.quantity)")
                                    .padding(4)
                                Text("Order at: \(item.inventory.reorderPoint)")
                                    .padding(4)
                                
                            }
                            
                            
                        }
                        .border(Color.black, width: 0.5)
                        
                    }
                    
                }
                
            }
            .background(Color.gray.opacity(0.1))

        }label:{
            
            Text("id: \(inv.first?.inventory.productId ?? 1)")
                .padding(4)

            Spacer()
            Text(inv.first?.inventory.productName ?? "group")
                .padding(4)

            Spacer()
            Text("Locations: \(inv.count)")
                .padding(4)

        }
        .border(Color.black, width: 1)

        
    }
   
    
    
}
