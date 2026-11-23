//
//  ProductListView.swift
//  Ios Capstone Group 4
//
//  Created by user302999 on 10/1/26.
//

import SwiftUI

struct InventoryListView: View {
    
    @State var InventoryName:String = ""
    
    @State private var viewModel:ViewModel
    var repo: any RepositoryProtocol<Inventory>
    init(repository: any RepositoryProtocol<Inventory>) {
        viewModel = ViewModel(repository:repository)
        repo = repository
    }
    
    var body: some View {
        
        NavigationStack{
            VStack(){
                
                VStack {
                    
                    VStack(){
                        HStack(){
                            TextField("Search Products...", text: $viewModel.filter)
                                .accessibilityLabel("Filter inventory products by product name")
                                .textFieldStyle(.roundedBorder)
                                .padding(20)
                            
                            Spacer()
                            Menu {
                                Button {
                                    viewModel.setSortDefault()
                                    viewModel.refreshInventories()
                                } label: {
                                    HStack{
                                        Text("No Sort")
                                        
                                        if(viewModel.currentSort == .none) {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                                .accessibilityLabel("Sort inventory product names by product ID")
                                
                                Button {
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
                                .accessibilityLabel("Sort inventory product names from A to Z")
                                
                                Button {
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
                                .accessibilityLabel("Sort inventory product names from Z to A")
                                
                                Divider()
                                
                                Button {
                                    viewModel.setLowStock()
                                    viewModel.selectedSort()
                                } label: {
                                    HStack{
                                        Text("Products with low stock")
                                        
                                        if(viewModel.currentSort == .lowStock) {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                                .accessibilityLabel("Sort inventory products by lowest amount of stock")
                                
                            } label: {
                                
                                Text("Sort By...")
                                    .padding(12)
                                    .background(Color.white, in: Capsule())
                                    .foregroundStyle(Color(red: 0.0, green: 0.1, blue: 0.6))
                                
                            }
                            .accessibilityLabel("Inventory product sorting")
                            .accessibilityHint("Options to sort inventory products")
                            .padding(12)
                            
                            
                        }
                        VStack(){
                            
                            VStack(){
                                HStack(){
                                    Text("Product Number")
                                        .frame(width: 80, alignment: .center)
                                    
                                    Text("Name")
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    
                                    Text("Locations")
                                        .frame(width: 90, alignment: .center)
                                    
                                }
                                .accessibilityElement(children: .ignore)
                                .accessibilityLabel("Inventory product fields: product number, name, and location")
                                
                                
                                
                                ScrollView(.vertical){
                                    LazyVStack{
                                        
                                        if(!viewModel.inventory.isEmpty){
                                            ForEach(viewModel.groupedArray, id: \.self){(inv: [InventoryUniqueItem]) in
                                                
                                                InventoryListRow(inv:inv,grouped:viewModel.groupedArray, repo:repo)
                                                
                                            }
                                        }else{
                                            Text(viewModel.errormsg)
                                                .foregroundColor(Color.red)
                                        }
                                        
                                    }
                                    .padding(8)
                                }
                                .refreshable{
                                    viewModel.filter = ""
                                    await viewModel.loadInventory()
                                }
                                
                            }
                            .task{
                                if(viewModel.inventoryUniqueItems.isEmpty){
                                    
                                        await viewModel.loadInventory()
                                  
                                }
                            }
                            .background(Color.white)
                            .frame(maxWidth: .infinity)
                            .padding(8)
                            
                        }
                    }
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    
                }
                .background(Color.cyan)
                .cornerRadius(20)
            }
            .navigationTitle("Inventory Catalog")
            
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        
        
        
    }
    
}


extension InventoryListView {
    
    @Observable
    class ViewModel{
        
        var errormsg = ""
        
        var selectedInventory: InventoryUniqueItem? = nil
        
        
        private let repository: any RepositoryProtocol<Inventory>
        init(repository:any RepositoryProtocol<Inventory>){
            self.repository = repository
        }
        
        enum sortOptions{
            case none,az,za,lowStock
        }
        
        var currentSort: sortOptions = .none
        
        //base default inventory pulled from remote repo
        var inventory: [Inventory] = []
        
        
        //an array of the unique inventory objects. this can be looped over
        var inventoryUniqueItems: [InventoryUniqueItem] = []{
            didSet{
                selectedInventory = nil
                matchingInventory = inventoryUniqueItems
            }
        }
        
//        enum DemoError:Error{
//            case demoError
//        }
        
        //pull inventory from the remote repo
        //wrap the inventory objects in another object making them unique,
        //group the inventory based on similar productIds
        func loadInventory()async{
            do{
               // throw DemoError.demoError
                inventory = try await repository.getAll()
                wrapInv(inv: inventory)
                groupInv(inventoryUnique: inventoryUniqueItems)
                matchingInventory = inventoryUniqueItems
            }catch{
                errormsg = "There was an error loading inventory: \(error). Please try refreshing."
                print(errormsg)
            }
        }
        
        
        //used to wrap inventory in a unique id object.
        //now every inventory object has a unique id to loop through in the view
        func wrapInv(inv:[Inventory]){
            for item in inventory{
                inventoryUniqueItems.append(InventoryUniqueItem(inventory: item))
            }
            
        }
        
        //this is the array that will be displayed.
        var groupedArray: [[InventoryUniqueItem]] = []
        
        
        //used to group the invetoryUnqueItems in the array based on their product ID
        //keeps products that are the same together regardless of location
        func groupInv(inventoryUnique:[InventoryUniqueItem]){
            let groupedDict = Dictionary(grouping:inventoryUnique){$0.inventory.id}
            groupedArray = Array(groupedDict.values)
        }
        
        
        var filter:String="" {
            didSet {
                refreshInventories()
            }
        }
        
        func refreshInventories() {
            selectedInventory = nil
            // Filter the items based on search text
            matchingInventory = inventoryUniqueItems.filter { item in
                filter.isEmpty || item.inventory.productName.lowercased().contains(filter.lowercased())
            }
            
            selectedSort()
        }
        
        //holds items for sorting. sort and filter here then load into groupedArray
        var matchingInventory:[InventoryUniqueItem] = []{
            didSet {
                // Automatically re-group whenever matchingInventory changes
                let dictionary = Dictionary(grouping: matchingInventory) { $0.inventory.productName }
                groupedArray = Array(dictionary.values).sorted(by: { $0.first!.inventory.productId < $1.first!.inventory.productId })
            }
        }
        
        var selectedSort: () -> Void = {}

        //MARK: HELPERS FOR FILTERS
        func setSortDefault() {
            selectedSort = {}
            currentSort = .none
        }
        
        func setSortAZ(){
            selectedSort = {
                self.groupedArray.sort {
                    ($0.first?.inventory.productName ?? "") < ($1.first?.inventory.productName ?? "")
                }
            }
            currentSort = .az
        }
        
        func setSortZA(){
            selectedSort = {
                self.groupedArray.sort {
                    ($0.first?.inventory.productName ?? "") > ($1.first?.inventory.productName ?? "")
                }
            }
            currentSort = .za
        }
        
        func setLowStock(){
            selectedSort = {
                self.groupedArray.sort { box1, box2 in
                    let min1 = box1.map { $0.inventory.quantity }.min() ?? 0
                    let min2 = box2.map { $0.inventory.quantity }.min() ?? 0
                    return min1 < min2
                }
            }
            currentSort = .lowStock
        }
        
    }
    
}
