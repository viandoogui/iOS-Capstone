//
//  LoginView.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 9/22/26.
//
import SwiftUI

struct LoginView : View{
    @EnvironmentObject var authStatus: AuthStatus
    
    @State private var viewModel = ViewModel()
    @State private var username: String = ""
    
    var body: some View {
        
        VStack {
            
            Text("AdventureWorks Internal Services")
                .font(Font.largeTitle.bold())
                .padding(10)
            
                
            VStack(spacing: 10) {
                    
                    VStack(spacing: 0) {
                        Text("Username")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 10)
                        TextField("Username", text: $viewModel.credentials.username)
                            .background(Color.white)
                            .cornerRadius(5)
                    }
                    .padding(10)
                    
                    VStack(spacing: 0) {
                        Text("Password")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 10)
                        SecureField("Password", text: $viewModel.credentials.password)
                            .background(Color.white)
                            .cornerRadius(5)
                    }
                    .padding(10)
                    
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
                            
                            authStatus.updateLoginStatus(response: resp)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .background(Color.white, in: Capsule())
                    .padding(.bottom, 10)
                    .disabled(viewModel.loginDisabled)
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                            .padding(.bottom, 10)

                    }
                    
                }
                .background(Color(red: 0.0, green: 0.35, blue: 0.6))
                .cornerRadius(10)
                .padding(20)
                .autocapitalization(.none)
                .disabled(viewModel.isBusy)

        
            
        }
        .background(Color.cyan)
        .cornerRadius(10)
        .frame(maxHeight: .infinity)
        
        
        
                
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

#Preview {
    LoginView()
}
