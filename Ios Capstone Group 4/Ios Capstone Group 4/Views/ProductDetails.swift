//
//  ProductDetails.swift
//  Ios Capstone Group 4
//
//  Created by user302999 on 10/1/26.
//

import SwiftUI

struct ProductDetails:View{
    @State  var product:Product

    var body: some View{
        Text("\(product.name)")
    }

}
