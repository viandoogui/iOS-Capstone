//
//  ProductListView.swift
//  Ios Capstone Group 4
//
//  Created by user302999 on 10/1/26.
//

import SwiftUI

struct ProductListView: View {
    @State private var viewModel:ViewModel = ViewModel()
    //@Environment(\.MockProductRepository) private var repo
    @State var productName:String = ""
    var body: some View {

        VStack{
            VStack(){
                HStack(){
                    Text("Back button")
                        .padding(12)
                    Spacer()
                    Text("Home Button")
                        .padding(12)
                }
                Text("Product Catalog!")
                    .font(Font.largeTitle)
                
                VStack(){
                    HStack(){
                        TextField("Search Products...", text: $viewModel.filter)
                            .textFieldStyle(.roundedBorder)
                            .padding(20)
                        
                        Spacer()
                        
                        Menu {
                            Button("Remove Filters") {
                                viewModel.filter = ""
                            }
                            
//                            Button("In Stock Only (MAYBE)") {
//                                // Apply filter logic
//                            }
                            
                            Button("A - Z") {
                                viewModel.sortAZ()
                            }

                            Divider()
                            
                            Button("Price: Low to High") {
                                viewModel.LowToHigh()
                            }
                            
                            
                            Button("Price: High to Low") {
                                viewModel.HighToLow()
                            }
                        } label: {
                            
                                Text("Filter")
                                .padding(18)
                                .foregroundColor(.black)
                                .background(Color.white)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                        }
                        .padding(12)
                        
                        
                    }
                    VStack(){
                        
                        VStack(){
                            HStack(){
                                Text("Product Number")
                                    .frame(width: 80, alignment: .center) // Fixed width for column 1
                                    .padding(4)

                                Text("Name")
                                    .frame(maxWidth: .infinity, alignment: .center) // Fills middle space
                                    .padding(4)

                                Text("Price")
                                    .frame(width: 90, alignment: .center) // Fixed width for column 3
                                    .padding(4)

                            }
                            //this is the place where you create the cards for the products
                            //each hstack is an entry gathered from the repo
                            NavigationStack{
                                ScrollView{
                                        ForEach(viewModel.matchingProduct){product in
                                            NavigationLink(value:product){
                                                HStack{
                                                    Text("\(product.id)")
                                                        .frame(width: 60, alignment: .center)
                                                    
                                                    Divider()
                                                    
                                                    Text("\(product.name)")
                                                        .frame(maxWidth: .infinity, alignment: .center)
                                                        .lineLimit(2)
                                                    
                                                    Divider()
                                                    
                                                    Text("\(String(format:"%.2f", product.listPrice))")
                                                        .frame(width: 90, alignment: .center)
                                                    
                                                }
                                                .frame(maxWidth: .infinity) //ensure horizontal center
                                                .background(Color.white)
                                                .padding(8)
                                                .border(Color.black, width: 1)
                                            }
                                            .padding(8)
                                        }
                                            //.navigationTitle("Products")
                                            .navigationDestination(for: Product.self) { selectedItem in
                                                ProductDetails(product: selectedItem) // Ensure 'productDetails' is a View (e.g., ProductDetailsView)

                                            }
                                    
                                }
                            }
                            
                        }
                        .task{
                            await viewModel.loadProducts()
                            

                        }
                        .frame(maxWidth: .infinity) //ensure horizontal center
                        .background(Color.white)
                        .padding(10)

                        
                    }
                }
                .background(Color.blue)
                .cornerRadius(20)
                .padding(10)
                .frame(maxWidth: .infinity) //ensure horizontal center

            }
            .padding(.top, 20)
            .background(Color.cyan)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
            
            
        Spacer()
            
        }
        .frame(maxWidth: .infinity) //ensure horizontal center
        .padding(10)
    }
}




extension ProductListView {
    
    @Observable
    class ViewModel{
        var products: [Product] = []{
            didSet{
                filter = ""
                selectedProduct = nil
            }
        }
        var errormsg = ""

        var selectedProduct: Product? = nil

        
        var mockRepo = MockProductRepository()
        
        func loadProducts()async{
//            async{
//                            guard let mockRepo = mockRepo else {
//                                errormsg = "no repository"
//                                return}
            
            do{
                products = try await mockRepo.getAll()
            }catch{
                errormsg = "error loading products"
            }
        }
        
        
        var filter:String="" {
            didSet{ //react to when changes have been made to this
               //put artists in matching artists if theres no filter or if the filter matches.
                matchingProduct = products.filter{ product in
                    filter == "" || product.name.lowercased().contains(filter.lowercased())
                }
                
            }
        }
       
        var matchingProduct:[Product] = []{
            didSet{
                if let selected = selectedProduct,
                   !matchingProduct.contains(selected){
                    selectedProduct = nil
                }
            }
        }
        
        
        
        //filter helper functions
//        func inStock()->[Product]{
        //maybe return to this or put in in inv screen if we have one
//        }
        
        func sortAZ(){
            matchingProduct = matchingProduct.sorted(by: { $0.name < $1.name })
        }
        
        func HighToLow(){
            matchingProduct = matchingProduct.sorted(by: { $0.id < $1.id })
        }
        
        func LowToHigh(){
            matchingProduct = matchingProduct.sorted(by: { $0.id > $1.id })
        }
        
        
    }
    
}
