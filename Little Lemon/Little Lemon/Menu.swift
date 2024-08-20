//
//  Menu.swift
//  Little Lemon
//
//  Created by LLH on 2024-08-19.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack {
            Text("Menu")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text("Chicago")
                .font(.subheadline)
            Text("Description")
            List {
                
            }
        }
    }
}

#Preview {
    Menu()
}
