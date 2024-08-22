//
//  Hero.swift
//  Little Lemon
//
//  Created by LLH on 2024-08-21.
//

import SwiftUI

struct Hero: View {
    var body: some View {
        VStack {
            Text("**Little Lemon**")
                .foregroundColor(Color.primaryColor2)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                VStack {
                    Text("Chicago")
                        .foregroundColor(.white)
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Text("""
                             We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.
                             """)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                Image("hero_image")
                    .resizable()
                    .aspectRatio( contentMode: .fill)
                    .frame(maxWidth: 130, maxHeight: 140)
                    .clipShape(Rectangle())
                    .cornerRadius(16)
            }
        }
        .padding([.top, .horizontal])
        .background(Color.primaryColor1)
        .frame(maxWidth: .infinity, maxHeight: 240)
    }
}

#Preview {
    Hero()
}
