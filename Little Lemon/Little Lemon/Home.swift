//
//  Home.swift
//  Little Lemon
//
//  Created by LLH on 2024-08-19.
//

import SwiftUI

struct Home: View {
    
    let persistence = PersistenceController.shared
    
    var body: some View {
        TabView {
            Menu()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            
            UserProfile()
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
