import SwiftUI
struct ContentView: View {
    
    @State private var current: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                switch current{
                case "home":
                    DefaultView()
                default:
                    LoginView()
                }	
            }
        }
    }
    
}

#Preview {
    ContentView()
}
