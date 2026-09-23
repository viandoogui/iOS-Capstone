import SwiftUI
struct ContentView: View {
    
    @State private var current: String = ""
    @State private var isLoggedIn = false
    var body: some View {
        NavigationStack {
            VStack {
                LoginView(isLoggedIn: isLoggedIn)
            }
        }
    }
    
}
