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

let kOrderStatuses = "order statuses key"
let kPasswordChanges = "password changes key"
let kSpecialOffers = "special offers key"
let kNewsletter = "news letter key"

let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    
    @StateObject private var viewModel = ViewModel()
    
    @State var isLoggedIn = false
    
    @State var isError = false
    @State var errorMessage = ""
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (alignment: .center) {
                    NavigationLink(destination: Home(), isActive: $isLoggedIn)
                    {
                        EmptyView()
                    }
                    Image("littleLemonLogo")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(maxHeight: 50)
                    Hero()
                        .padding(.bottom)
                        .background(Color.primaryColor1)
                    VStack (alignment: .leading) {
                        Text("\nFirst name *")
                        TextField("First name", text: $firstName)
                        Text("\nLast name *")
                        TextField("Last name", text: $lastName)
                        Text("\nEmail *")
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                    }
                    .padding()
                    Button(action: {
                        (isError, errorMessage) = viewModel.isValidInputs(firstName: firstName, lastName: lastName, email: email)
                        if !isError {
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                            isLoggedIn.toggle()
                        }
                    }, label: {
                        Text("Register")
                    })
                    .padding()
                    .buttonStyle(.borderedProminent)
                    .tint(.primaryColor1)
                }
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
    }
    
}

#Preview {
    Onboarding()
}
