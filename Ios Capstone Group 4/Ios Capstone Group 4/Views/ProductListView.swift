//
//  ProductListView.swift
//  Ios Capstone Group 4
//
//  Created by user302999 on 10/1/26.
//

import SwiftUI

struct ProductListView: View {
    //@State private var viewModel:ViewModel = ViewModel()
    //@Environment(\.MockProductRepository) private var repo
    @State var productName:String = ""
    
    @State private var viewModel:ViewModel
    init(repository: any RepositoryProtocol<Product>) {
        viewModel = ViewModel(repository:repository)
    }
    
    var body: some View {

        NavigationStack{
                VStack(){
//                   HStack(){
//                        //Text("Back button")
//                        //  .padding(12)
//                        Spacer()
//                        Text("Home Button")
//                            .padding(12)
//                    }
                
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
                                    viewModel.currentSort = .none
                                    viewModel.matchingProduct = viewModel.products
                                }
                                
                                //                            Button("In Stock Only (MAYBE)") {
                                //                                // Apply filter logic
                                //                            }
                                
                                Button("A - Z") {
                                    viewModel.sortAZ()
                                }
                                
                                Button("Z - A"){
                                    viewModel.sortZA()
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
                                       // .padding(4)
                                    
                                    Text("Name")
                                        .frame(maxWidth: .infinity, alignment: .center) // Fills middle space
                                        //.padding(4)
                                    
                                    Text("Price")
                                        .frame(width: 90, alignment: .center) // Fixed width for column 3
                                        //.padding(4)
                                    
                                }
                                
                                
                                NavigationStack{
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
                        .frame(maxWidth: .infinity) //ensure horizontal center
                        .background(Color.white)
                        .padding(8)
                            
                    }//nav stack
                }//vstack
                .background(Color.blue)
                .cornerRadius(20)
                .padding(8)
                .frame(maxWidth: .infinity) //ensure horizontal center
                    
        }//vstack with title
        .background(Color.cyan)
            
    }
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(Color.cyan)


    }//body

}//end




extension ProductListView {
    
    @Observable
    class ViewModel{
        
        enum sortOptions{
            case none,az,za,priceLowToHigh,priceHighToLow
        }
        var currentSort = sortOptions.none
        
        var errormsg = ""

        var selectedProduct: Product? = nil

        
        //var mockRepo = MockProductRepository()
        private let repository: any RepositoryProtocol<Product>
        init(repository:any RepositoryProtocol<Product>){
            self.repository = repository
            print("init")
        }
        
        var products: [Product] = []{
            didSet{
                filter = ""
                selectedProduct = nil
            }
        }
            
        
        func loadProducts()async{
            do{
                products = try await repository.getAll()
                matchingProduct = products
                //print(products)
            }catch{
                errormsg = "error loading products: \(error)"
                print(errormsg)
            }
        }
        
         var filter:String="" {
            didSet{ //react to when changes have been made to this
               //put products in matching products if theres no filter or if the filter matches.
                matchingProduct = products.filter{ product in
                    filter.isEmpty || product.name.lowercased().contains(filter.lowercased())
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
        
        
        
        //MARK: helpers for filters
        func sortAZ(){
            currentSort = .az
            matchingProduct = matchingProduct.sorted(by: { $0.name < $1.name })
        }
        
        func sortZA(){
            currentSort = .za
            matchingProduct = matchingProduct.sorted(by: { $0.name > $1.name })
        }
        
        func HighToLow(){
            currentSort = .priceHighToLow
            matchingProduct = matchingProduct.sorted(by: { $0.listPrice > $1.listPrice })
        }
        
        func LowToHigh(){
            currentSort = .priceLowToHigh
            matchingProduct = matchingProduct.sorted(by: { $0.listPrice > $1.listPrice })
        }
        
        
        
       
        
        
    }
    
}
