//
//  UserProfile.swift
//  Little Lemon
//
//  Created by LLH on 2024-08-19.
//

import SwiftUI

let firstName = UserDefaults.standard.string(forKey: kFirstName)
let lastName = UserDefaults.standard.string(forKey: kLastName)
let email = UserDefaults.standard.string(forKey: kEmail)


struct UserProfile: View {
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Personal information")
            Image("profile_placeholder")
                .resizable()
                .scaledToFit()
            Text(firstName ?? "")
            Text(lastName ?? "")
            Text(email ?? "")
            Button(action: {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }, label: {
                Text("Logout")
            })
            .buttonStyle(.bordered)
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
