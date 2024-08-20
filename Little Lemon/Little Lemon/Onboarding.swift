//
//  Onboarding.swift
//  Little Lemon
//
//  Created by LLH on 2024-08-19.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"

let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    
    @State var isLoggedIn = false
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    
    @State var isError = false
    @State var errorMessage = ""
    
    var body: some View {
        NavigationView {
            VStack (alignment: .center) {
                NavigationLink(destination: Home(), isActive: $isLoggedIn)
                {
                    EmptyView()
                }
                TextField("First name", text: $firstName)
                TextField("Last name", text: $lastName)
                TextField("Email", text: $email)
                Button(action: {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        if isValidEmail(email) {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                            isLoggedIn.toggle()
                        }
                        else {
                            errorMessage = "Please enter a valid email."
                            isError.toggle()
                        }
                    }
                    else {
                        errorMessage = "Please enter all fields."
                        isError.toggle()
                    }
                }, label: {
                    Text("Register")
                })
                .padding()
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            .alert(isPresented: $isError, content: {
                Alert(title: Text("Error"), message: Text(errorMessage))
            })
            .onAppear() {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
        }
        }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}

#Preview {
    Onboarding()
}
