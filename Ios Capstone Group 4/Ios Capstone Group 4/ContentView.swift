import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authStatus: AuthStatus
    @Environment(\.verticalSizeClass) var sizeClass
    @State private var current: String = ""
    let urlBase: String
    let username: String
    
    var body: some View {
        
        NavigationStack {
            VStack {
                switch current {
                case "employee":
                    EmployeeList(repository: RemoteEmployeeRepository(urlBase: urlBase, authStatus: authStatus))
                        .accessibilityIdentifier("employeeView")
                case "product":
                    ProductListView(repository: RemoteProductRepository(urlBase: urlBase, authStatus: authStatus))
                        .accessibilityIdentifier("productView")
                case "order":
                    OrderListView(repository: RemoteOrderRepository(urlBase: urlBase, authStatus: authStatus))
                        .accessibilityIdentifier("boardView")
                default:
                    if(sizeClass == .compact) {
                        VStack (spacing: 20) {
                            Button("Log out") {
                                authStatus.logOut()
                            }.buttonStyle(.borderedProminent)
                                .font(.title3)
                                .tint(.gray)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.top, 15)
                                .padding(.trailing, 15)
                            .accessibilityIdentifier("logoutButton")
                            
                            VStack (){
                                Text("Welcome Back\(username == "" ? "!" : ", \(username)!")")
                                    .foregroundStyle(.white)
                                    .font(.title)
                                    .padding(10)
                            }
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(20)
                                .padding(10)
                                
                            
                            VStack (spacing: 10){
                                HStack {
                                    Button("Operational Dashboard") {
                                        
                                    }.buttonStyle(.borderedProminent)
                                        .tint(.gray)
                                        .font(.title)
                                    Button("Employee Directory") {
                                        current = "employee"
                                    }.buttonStyle(.borderedProminent)
                                        .tint(.gray)
                                        .font(.title)
                                }
                                .padding(.top, 10)
                                
                                HStack {
                                    Button("Product List") {
                                        current = "product"
                                    }.buttonStyle(.borderedProminent)
                                        .tint(.gray)
                                        .font(.title)
                                    .accessibilityIdentifier("employeeViewButton")
                                    Button("Order Review") {
                                        current = "order"
                                    }.buttonStyle(.borderedProminent)
                                        .tint(.gray)
                                        .font(.title)
                                }
                                
                                
                                Button("Inventory Management") {
                                    
                                }.buttonStyle(.borderedProminent)
                                    .tint(.gray)
                                    .font(.title)
                                    .padding(.bottom, 10)

                                .accessibilityIdentifier("orderViewButton")
                                
                            }
                            .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(30)
                                .padding(10)
                                                    }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                            .background(Color.cyan)
                            .cornerRadius(20)
                    }
                    else {
                        VStack (spacing: 40) {
                            Button("Log out") {
                                authStatus.logOut()
                            }.buttonStyle(.borderedProminent)
                                .font(.title3)
                                .tint(.gray)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.top, 15)
                                .padding(.trailing, 15)
                            .accessibilityIdentifier("logoutButton")
                            
                            VStack (){
                                Text("Welcome Back\(username == "" ? "!" : ", \(username)!")")
                                    .foregroundStyle(.white)
                                    .font(.title)
                                    .padding(10)
                            }
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(20)
                                .padding(10)
                                
                            
                            VStack (spacing: 40){
                                Button("Operational Dashboard") {
                                    
                                }.buttonStyle(.borderedProminent)
                                    .tint(.gray)
                                    .font(.title)
                                    .padding(.top, 20)
                                Button("Employee Directory") {
                                    current = "employee"
                                }.buttonStyle(.borderedProminent)
                                    .tint(.gray)
                                    .font(.title)
                                Button("Product List") {
                                    current = "product"
                                }.buttonStyle(.borderedProminent)
                                    .tint(.gray)
                                    .font(.title)
                                .accessibilityIdentifier("employeeViewButton")
                                Button("Order Review") {
                                    current = "order"
                                }.buttonStyle(.borderedProminent)
                                    .tint(.gray)
                                    .font(.title)
                                Button("Inventory Management") {
                                    
                                }.buttonStyle(.borderedProminent)
                                    .tint(.gray)
                                    .font(.title)
                                    .padding(.bottom, 20)

                                .accessibilityIdentifier("orderViewButton")
                                
                            }
                            .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(30)
                                .padding(10)
                                                    }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                            .background(Color.cyan)
                            .cornerRadius(20)
                    }
                    
                    
                        
                        
                }
            }
            .toolbar {
               
                ToolbarItem() {
                    Button( action: {
                        current = ""
                    } ) {
                        Image(systemName: "house")
                    }
                }
                
            }
            .toolbarVisibility(current == "" ? .hidden : .visible, for: .navigationBar)
        }
        
    }
}

#Preview {
    ContentView(urlBase: "", username: "ken")
}
