//
//  ProductListRow.swift
//  Ios Capstone Group 4
//
//  Created by user302999 on 10/15/26.
//

import SwiftUI
struct ProductListRow:View {
    
        var product:Product
        init(product:Product) {
            self.product = product
        }
    
    var body: some View {
        
        NavigationLink(destination:ProductDetails(product:product)){
            HStack(spacing:16){
                Text("\(product.id)")
                    .frame(width: 40, alignment: .center)

                Divider()

                Text("\(product.name)")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .lineLimit(2)

                Divider()

                Text("$\(String(format:"%.2f", product.listPrice))")
                    .frame(width: 75, alignment: .center)

            }
            .frame(maxWidth: .infinity) //ensure horizontal center
            .background(Color.white)
            .foregroundStyle(Color(red: 0.0, green: 0.1, blue: 0.6))
            .padding(8)
            .border(Color.black, width: 1)
        }
        .padding(8)
        
    }
    //.frame(maxWidth: .infinity) //ensure horizontal center
    //.background(Color.white)
    //.padding(10)
    
    
}
