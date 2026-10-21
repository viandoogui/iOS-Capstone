import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authStatus: AuthStatus
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
                case "order":
                    OrderListView(repository: RemoteOrderRepository(urlBase: urlBase, authStatus: authStatus))
                        .accessibilityIdentifier("boardView")
                default:
                    VStack{
                        Button("Log out") {
                            authStatus.updateLoginStatus(success: false)
                        }.buttonStyle(.borderedProminent)
                            .tint(.gray)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.top, 15)
                            .padding(.trailing, 15)
                        .accessibilityIdentifier("logoutButton")
                        
                        VStack (){
                            Text("Welcome Back,")
                                .foregroundStyle(.white)
                                .padding(10)
                            Text(username)
                                .foregroundStyle(.white)
                                .padding(10)
                        }
                            .frame(maxWidth: .infinity).background(Color.blue)
                            .padding(10)
                            .cornerRadius(30)
                        
                        Spacer()
                        VStack (spacing: 20){
                            Button("Employee Directory") {
                                current = "employee"
                            }.buttonStyle(.borderedProminent)
                                .tint(.gray)
                            .accessibilityIdentifier("employeeViewButton")
                            Button("Order Review") {
                                current = "order"
                            }.buttonStyle(.borderedProminent)
                                .tint(.gray)
                                
                            .accessibilityIdentifier("orderViewButton")
                            
                        }.frame(maxWidth: .infinity).background(Color.blue)
                            .padding(10)
                            .cornerRadius(30)
                            .padding(.horizontal, 15).frame(maxWidth: .infinity).background(Color.blue)
                            .padding(10)
                            .cornerRadius(30)
                    }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.cyan)
                        .cornerRadius(20)
                        
                        
                }
            }
        }
        
    }
}

#Preview {
    ContentView(urlBase: "", username: "ken")
}
