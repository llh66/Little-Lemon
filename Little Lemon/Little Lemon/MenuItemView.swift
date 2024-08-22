//
//  MenuItemView.swift
//  Little Lemon
//
//  Created by LLH on 2024-08-22.
//

import SwiftUI

struct MenuItemView: View {
    let dish: Dish
    var body: some View {
        VStack(alignment: .leading) {
            Text(dish.title ?? "Dish Name")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            HStack {
                VStack(alignment: .leading) {
                    Text(dish.dishDescription ?? "Dish Description")
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    Text("$" + (dish.price ?? "Dish Price"))
                        .font(.title3)
                        .padding(.top)
                }
                .foregroundColor(Color.primaryColor1)
                
                Spacer()
                
                AsyncImage(url: URL(string: dish.image ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 90, height: 90)
                .clipShape(Rectangle())
            }
        }
    }
}

#Preview {
    MenuItemView(dish: Dish(context: PersistenceController.shared.container.viewContext))
}
