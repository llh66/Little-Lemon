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
        Menu()
            .environment(\.managedObjectContext, persistence.container.viewContext)
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
