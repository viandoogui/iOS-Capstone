//
//  LoginView.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 9/22/26.
//
import SwiftUI

struct LoginView : View{
    
    @State private var viewModel = ViewModel()
    @State private var isLoggedIn: Bool = false
    
    init(isLoggedIn: Bool) {
        self.isLoggedIn = isLoggedIn
    }
    
    var body: some View {
        VStack {
            Text("Login")
                .font(Font.largeTitle.bold())
            
            TextField("Username", text: $viewModel.credentials.username)
            SecureField("Password", text: $viewModel.credentials.password)
            
            if viewModel.isBusy {
                ProgressView()
            }
            
            Button("Log in") {
                Task {
                    let response = await viewModel.login()
                    guard let resp = response else {
                        viewModel.errorMessage = "resp is null, cannot log in"
                        return
                    }
                    
                    if resp.success {
                        isLoggedIn = true
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.loginDisabled).navigationDestination(isPresented: $isLoggedIn) {
                DefaultView(isLoggedIn: isLoggedIn)
            }
            
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(Color.red)
            }
            
            Spacer()
            
        }
        .padding(20)
        .autocapitalization(.none)
        .disabled(viewModel.isBusy)
    }
}

extension LoginView {
    
    @Observable
    class ViewModel {
        var credentials = LoginModel()
        var isBusy = false
        
        var loginDisabled: Bool {
            credentials.username.isEmpty || credentials.password.isEmpty
        }
        
        var errorMessage: String = ""
        
        func login() async -> LoginResponseModel? {
            isBusy = true
            do {
                let result = try await AuthService.shared.login(credentials: credentials)
                isBusy = false
                
                if !result.success {
                    errorMessage = "Invalid username/password combination"
                }
                return result
            }
            catch {
                errorMessage = "\(error)"
            }
            isBusy = false
            return nil
        }
        
    }
}
