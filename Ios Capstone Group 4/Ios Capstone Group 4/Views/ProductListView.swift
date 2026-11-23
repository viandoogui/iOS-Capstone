//
//  ProductListView.swift
//  Ios Capstone Group 4
//
//  Created by user302999 on 10/1/26.
//

import SwiftUI
internal import Combine

struct ProductListView: View {

    @State var productName:String = ""
    
    @State private var viewModel:ViewModel
    init(repository: any RepositoryProtocol<Product>) {
        viewModel = ViewModel(repository:repository)
    }
    
    var body: some View {

        NavigationStack{
            VStack{
                VStack(){
                    
                    VStack(spacing: 0){
                        HStack(){
                            TextField("Search Products...", text: $viewModel.filter)
                                .textFieldStyle(.roundedBorder)
                                .padding(20)
                                .accessibilityLabel("Search for Products by name")
                            
                            Menu {
                                Button {
                                    viewModel.clearSort()
                                    viewModel.refilterProducts()
                                } label: {
                                    HStack{
                                        Text("No Sort")
                                        
                                        if(viewModel.currentSort == .none) {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            
                                .accessibilityLabel("No product sorting")
                                
                                Button() {
                                    viewModel.setSortAZ()
                                    viewModel.selectedSort()
                                } label: {
                                    HStack{
                                        Text("A - Z")
                                        
                                        if(viewModel.currentSort == .az) {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                                .accessibilityLabel("Sort product names from A to Z")
                                
                                Button(){
                                    viewModel.setSortZA()
                                    viewModel.selectedSort()
                                } label: {
                                    HStack{
                                        Text("Z - A")
                                        
                                        if(viewModel.currentSort == .za) {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                                .accessibilityLabel("Sort product names from Z to A")
                                
                                Divider()
                                
                                Button() {
                                    viewModel.setLowToHigh()
                                    viewModel.selectedSort()
                                } label: {
                                    HStack{
                                        Text("Price: Low to High")
                                        
                                        if(viewModel.currentSort == .priceLowToHigh) {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                                .accessibilityLabel("Sort product prices from lowest to highest")
                                
                                Button() {
                                    viewModel.setHighToLow()
                                    viewModel.selectedSort()
                                } label: {
                                    HStack{
                                        Text("Price: High to Low")
                                        
                                        if(viewModel.currentSort == .priceHighToLow) {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                                .accessibilityLabel("Sort product prices from highest to lowest")
                                
                            } label: {
                                Text("Sort By...")
                                    .padding(12)
                                    .background(Color.white, in: Capsule())
                                    .foregroundStyle(Color(red: 0.0, green: 0.1, blue: 0.6))
                                    .accessibilityLabel("Options to sort the products")
                            }
                            .padding(12)
                            
                            
                        }
                        VStack(){
                            
                            VStack(){
                                HStack(){
                                    Text("Product Number")
                                        .frame(width: 80, alignment: .center) // Fixed width for column 1
                                    
                                    Text("Name")
                                        .frame(maxWidth: .infinity, alignment: .center) // Fills middle space
                                    
                                    Text("Price")
                                        .frame(width: 90, alignment: .center) // Fixed width for column 3
                                }
                                .accessibilityElement(children: .ignore)
                                .accessibilityLabel("Product fields: product number, name, and price")
                                
                                NavigationStack{
                                    
                                    if viewModel.isLoading {
                                        ProgressView("Loading products...")
                                            .padding()
                                    }
                                    
                                    if !viewModel.errormsg.isEmpty {
                                        Text(viewModel.errormsg)
                                            .foregroundColor(.black)
                                        
                                        Button("Try Again") {
                                            Task {
                                                await viewModel.loadProducts()
                                            }
                                        }
                                        .padding(12)
                                        .background(Color.white, in: Capsule())
                                        .foregroundStyle(Color(red: 0.0, green: 0.1, blue: 0.6))
                                    }
                                    
                                    ScrollView(.vertical){
                                        LazyVStack{
                                            ForEach(viewModel.matchingProduct){product in
                                                
                                                ProductListRow(product: product) //each individual product row
                                                
                                            }
                                            
                                            
                                        }
                                    }
                                }
                            }
                            .task{
                                if(viewModel.products.isEmpty){
                                    await viewModel.loadProducts()
                                    
                                }
                            }
                            .frame(maxWidth: .infinity) 
                            .background(Color.white)
                            .padding(8)
                            
                        }
                        .navigationTitle("Product List")
                    }
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    
                }
                .background(Color.cyan)
                .cornerRadius(20)
            }
    }
            .frame(maxWidth: .infinity)
            .padding(10)
 


    }

}




extension ProductListView {
    
    @Observable
    class ViewModel{
        
        var errormsg = ""
        var isLoading = true

        var selectedProduct: Product? = nil

        enum sortOptions{
            case none,az,za,priceLowToHigh,priceHighToLow
        }
        
        var currentSort: sortOptions = .none
        
        private let repository: any RepositoryProtocol<Product>
        init(repository:any RepositoryProtocol<Product>){
            self.repository = repository
        }
        
        var products: [Product] = []{
            didSet{
                filter = ""
                selectedProduct = nil
            }
        }
        
        func loadProducts() async {

            isLoading = true
            errormsg = ""

            do{
                products = try await repository.getAll()
                matchingProduct = products
                isLoading = false
            } catch {
                errormsg = "Couldn't load products. Please try again."
                isLoading = false
            }
        }
        
         var filter:String="" {
            didSet { //react to when changes have been made to this
               //put products in matching products if theres no filter or if the filter matches.
                refilterProducts()
            }
        }
       
        func refilterProducts() {
            let trimmed = filter.trimmingCharacters(in: .whitespacesAndNewlines)
            if !filter.isEmpty && trimmed.isEmpty {
                matchingProduct = []
            } else{
                matchingProduct = products.filter{ product in
                    filter.isEmpty || product.name.lowercased().contains(filter.lowercased())
                }
            }
            
            selectedSort()
        }
        
        var matchingProduct:[Product] = []{
            didSet{
                if let selected = selectedProduct,
                   !matchingProduct.contains(selected){
                    selectedProduct = nil
                }
            }
        }
        
        //MARK: helpers for filters
        
        var selectedSort: () -> Void = {}
        
        func clearSort() {
            selectedSort = {}
            currentSort = sortOptions.none
        }
        
        func setSortAZ(){
            selectedSort = {
                self.matchingProduct = self.matchingProduct.sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
            }
            currentSort = sortOptions.az
        }
        
        func setSortZA(){
            selectedSort = {
                self.matchingProduct = self.matchingProduct.sorted { $0.name.localizedStandardCompare($1.name) == .orderedDescending }
            }
            currentSort = sortOptions.za
        }
        
        func setHighToLow(){
            selectedSort = {
                self.matchingProduct = self.matchingProduct.sorted(by: { $0.listPrice > $1.listPrice })
            }
            currentSort = sortOptions.priceHighToLow
        }
        
        func setLowToHigh(){
            selectedSort = {
                self.matchingProduct = self.matchingProduct.sorted(by: { $0.listPrice < $1.listPrice })
            }
            currentSort = sortOptions.priceLowToHigh
        }
        
        
    }
    
}
