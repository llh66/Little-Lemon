//
//  UserProfile.swift
//  Little Lemon
//
//  Created by LLH on 2024-08-19.
//

import SwiftUI


struct UserProfile: View {
    
    @Environment(\.presentationMode) var presentation
    
    @StateObject private var viewModel = ViewModel()
    
    @State private var isLoggedOut = false
    
    @State var firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State var lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State var email = UserDefaults.standard.string(forKey: kEmail) ?? ""

    @State var orderStatuses = UserDefaults.standard.bool(forKey: kOrderStatuses)
    @State var passwordChanges = UserDefaults.standard.bool(forKey: kPasswordChanges)
    @State var specialOffers = UserDefaults.standard.bool(forKey: kSpecialOffers)
    @State var newsletter = UserDefaults.standard.bool(forKey: kNewsletter)
    
    @State var isError = false
    @State var errorMessage = ""
    
    var body: some View {
        NavigationLink(destination: Onboarding(), isActive: $isLoggedOut) { }
        ZStack {
            Image("littleLemonLogo")
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(maxHeight: 50)
            HStack {
                Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "arrow.backward.circle.fill")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(maxHeight: 40)
                            .padding(.leading)
                            .foregroundColor(Color.primaryColor1)
                    }
                }
                Spacer()
                Image("profile_placeholder")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(maxHeight: 50)
                    .clipShape(Circle())
                    .padding(.trailing)
            }
        }
        ScrollView {
            VStack(alignment:.leading) {
                Text("Personal information")
                    .font(.title3)
                Text("Avatar")
                    .font(.caption)
                    .padding(.top, 1)
                HStack {
                    Image("profile_placeholder")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(maxHeight: 100)
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Change")
                            .padding()
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 2))
                    })
                    .background(Color.primaryColor1)
                    .cornerRadius(10)
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Remove")
                            .padding()
                            .foregroundColor(.primaryColor1)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.primaryColor1, lineWidth: 2))
                    })
                    .background(Color.white)
                    .cornerRadius(10)
                }
                Text("First name")
                    .font(.caption)
                    .padding(.top, 1)
                TextField("First name", text: $firstName)
                Text("Last name")
                    .font(.caption)
                    .padding(.top, 1)
                TextField("Last name", text: $lastName)
                Text("Email")
                    .font(.caption)
                    .padding(.top, 1)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                
                Text("Email Notifications")
                    .font(.title3)
                    .padding(.top, 5)
                Toggle("Order statuses", isOn: $orderStatuses)
                Toggle("Password changes", isOn: $passwordChanges)
                Toggle("Special offers", isOn: $specialOffers)
                Toggle("Newsletter", isOn: $newsletter)
                Button(action: {
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    isLoggedOut = true
                }, label: {
                    Text("**Logout**")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.orange, lineWidth: 2))
                })
                .background(Color.primaryColor2)
                .cornerRadius(10)
                .padding(.top, 20)
                HStack {
                    Spacer()
                    Button(action: {
                        firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
                        lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
                        email = UserDefaults.standard.string(forKey: kEmail) ?? ""

                        orderStatuses = UserDefaults.standard.bool(forKey: kOrderStatuses)
                        passwordChanges = UserDefaults.standard.bool(forKey: kPasswordChanges)
                        specialOffers = UserDefaults.standard.bool(forKey: kSpecialOffers)
                        newsletter = UserDefaults.standard.bool(forKey: kNewsletter)
                        
                        self.presentation.wrappedValue.dismiss()
                    }, label: {
                        Text("**Discard Changes**")
                            .padding()
                            .foregroundColor(.primaryColor1)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.primaryColor1, lineWidth: 2))
                    })
                    .background(Color.white)
                    .cornerRadius(10)
                    Spacer()
                    Button(action: {
                        (isError, errorMessage) = viewModel.isValidInputs(firstName: firstName, lastName: lastName, email: email)
                        if !isError {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            
                            UserDefaults.standard.set(orderStatuses, forKey: kOrderStatuses)
                            UserDefaults.standard.set(passwordChanges, forKey: kPasswordChanges)
                            UserDefaults.standard.set(specialOffers, forKey: kSpecialOffers)
                            UserDefaults.standard.set(newsletter, forKey: kNewsletter)
                            
                            self.presentation.wrappedValue.dismiss()
                        }
                    }, label: {
                        Text("**Save Changes**")
                            .padding()
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 2))
                    })
                    .background(Color.primaryColor1)
                    .cornerRadius(10)
                    .alert(isPresented: $isError, content: {
                        Alert(title: Text("Error"), message: Text(errorMessage))
                    })
                    Spacer()
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 20)
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            .toggleStyle(iOSCheckboxToggleStyle())
        }
        .onAppear {
            firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
            lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
            email = UserDefaults.standard.string(forKey: kEmail) ?? ""

            orderStatuses = UserDefaults.standard.bool(forKey: kOrderStatuses)
            passwordChanges = UserDefaults.standard.bool(forKey: kPasswordChanges)
            specialOffers = UserDefaults.standard.bool(forKey: kSpecialOffers)
            newsletter = UserDefaults.standard.bool(forKey: kNewsletter)
        }
    }
}

#Preview {
    UserProfile()
}
