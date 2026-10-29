//
//  ProductListView.swift
//  Ios Capstone Group 4
//
//  Created by user302999 on 10/1/26.
//

import SwiftUI

struct InventoryListView: View {
    //@State private var viewModel:ViewModel = ViewModel()
    //@Environment(\.MockProductRepository) private var repo
    @State var InventoryName:String = ""
    
    @State private var viewModel:ViewModel
    init(repository: any RepositoryProtocol<Inventory>) {
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
                
                    Text("Inventory Catalog!")
                        .font(Font.largeTitle)
                    
                    VStack(){
                        HStack(){
                            TextField("Search Products...", text: $viewModel.filter)
                                .textFieldStyle(.roundedBorder)
                                .padding(20)
                            
                            Spacer()
                            //MARK: need to add filters
                            Menu {
                                Button("Remove Filters") {
                                    viewModel.filter = ""
                                    viewModel.currentSort = .none
                                }
                                
                                
                                
                                Button("A - Z") {
                                    viewModel.sortAZ()
                                }
                                
                                Button("Z - A"){
                                    viewModel.sortZA()
                                }
                                Divider()
                                Button("Products with low stock") {
                                    viewModel.lowStock()
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
                                    
                                    Text("Locations")
                                        .frame(width: 90, alignment: .center) // Fixed width for column 3
                                        //.padding(4)
                                    
                                }
                                
                                
                               
                                    ScrollView(.vertical){
                                        LazyVStack{

                                            ForEach(viewModel.groupedArray, id: \.self){(inv: [InventoryUniqueItem]) in
                                                
                                                InventoryListRow(inv:inv,grouped:viewModel.groupedArray)
                                                
                                                
                                            }

                                        }
                                        .padding(8)
                                    }
                            
                        }
                            .task{
                                if(viewModel.inventoryUniqueItems.isEmpty){
                                    await viewModel.loadInventory()

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




extension InventoryListView {
    
    @Observable
    class ViewModel{
        
        enum sortOptions{
            case none,az,za,lowStock
        }
        var currentSort = sortOptions.none
        
        var errormsg = ""

        var selectedInventory: InventoryUniqueItem? = nil

        
        private let repository: any RepositoryProtocol<Inventory>
        init(repository:any RepositoryProtocol<Inventory>){
            self.repository = repository
            print("init")
        }
        
        //base default inventory pulled from remote repo
        var inventory: [Inventory] = []
      
        
        //an array of the unique inventory objects. this can be looped over
        var inventoryUniqueItems: [InventoryUniqueItem] = []{
            didSet{
                filter = ""
                selectedInventory = nil
                matchingInventory = inventoryUniqueItems
            }
        }
        
        
        //pull inventory from the remote repo
        //wrapp the inventory objects in another object making them uniuqe,
        //group the inventory based on similar productIds
        func loadInventory()async{
            do{
                inventory = try await repository.getAll()
                wrapInv(inv: inventory)
                groupInv(inventoryUnique: inventoryUniqueItems)
                matchingInventory = inventoryUniqueItems
            }catch{
                errormsg = "error loading inventory: \(error)"
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
                    selectedInventory = nil
                    // Filter the items based on search text
                    matchingInventory = inventoryUniqueItems.filter { item in
                        filter.isEmpty || item.inventory.productName.lowercased().contains(filter.lowercased())
                    }
            }
        }
       
        //holds items for sorting. sort and filter here then load into groupedArray
        var matchingInventory:[InventoryUniqueItem] = []{
            didSet {
                // Automatically re-group whenever matchingInventory changes
                let dictionary = Dictionary(grouping: matchingInventory) { $0.inventory.productName }
                groupedArray = Array(dictionary.values)
            }
        }

        
//        func printinv(inv:[InventoryUniqueItem]){
//            for item in inv{
//                print(item.inventory.productId)
//               // print(item.inventory.productName)
//                //print(item.inventory.locationName)
//                //print(item.inventory.quantity)
//                print("-----")
//                
//            }
//        }
        
//        func printinvGrouped(inv:[[InventoryUniqueItem]]){
//            for items in inv {
//                    // Grab the ID from the first item in the group
//                    if let firstItem = items.first {
//                        print("Inventory ID: \(firstItem.inventory.id)")
//                    }
//                    
//                    for item in items {
//                        print("  - Product ID: \(item.inventory.productId)")
//                        print("  - Product Name: \(item.inventory.productName)")
//                    }
//                    print("-------------------")
//                }
//        }
        

        
        
        //MARK: HELPERS FOR FILTERS
        func sortAZ(){
            currentSort = .az
                
                groupedArray.sort {
                    ($0.first?.inventory.productName ?? "") < ($1.first?.inventory.productName ?? "")
                }
        }
        
        func sortZA(){
            currentSort = .za
            groupedArray.sort {
                ($0.first?.inventory.productName ?? "") > ($1.first?.inventory.productName ?? "")
            }
        }
        
        func lowStock(){
            currentSort = .lowStock
            groupedArray.sort { box1, box2 in
                    let min1 = box1.map { $0.inventory.quantity }.min() ?? 0
                    let min2 = box2.map { $0.inventory.quantity }.min() ?? 0
                    return min1 < min2
                }
        }

        
        
       
        
        
    }
    
}
