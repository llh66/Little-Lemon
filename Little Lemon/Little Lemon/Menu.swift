//
//  Menu.swift
//  Little Lemon
//
//  Created by LLH on 2024-08-19.
//

import SwiftUI

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var searchText = ""
    
    @State var isStarters = true
    @State var isMains = true
    @State var isDesserts = true
    @State var isDrinks = true
    
    @State var isKeyboardVisible = false
    
    @State var isMenuSet = false
    
    var body: some View {
        VStack {
//            ZStack {
                Image("littleLemonLogo")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(maxHeight: 50)
//                HStack {
//                    Spacer()
////                    NavigationLink(destination: UserProfile()
////                        .navigationBarHidden(true)) {
//                    Image("profile_placeholder")
//                        .resizable()
//                        .aspectRatio( contentMode: .fit)
//                        .frame(maxHeight: 50)
//                        .clipShape(Circle())
//                        .padding(.trailing)
////                    }
//                }
//            }
            VStack {
                if !isKeyboardVisible {
                    withAnimation() {
                        Hero()
                    }
                }
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding()
                    TextField("Search menu", text: $searchText)
                        .padding()
                }
                .background(Capsule().fill(Color.white))
                .padding()
            }
            .background(Color.primaryColor1)
            
            VStack(alignment: .leading) {
                Text("**ORDER FOR DELIVERY!**")
                    .padding([.horizontal, .top])
                ScrollView(.horizontal) {
                    HStack{
                        Toggle("Starters", isOn: $isStarters)
                        Toggle("Mains", isOn: $isMains)
                        Toggle("Desserts", isOn: $isDesserts)
                        Toggle("Drinks", isOn: $isDrinks)
                    }
                    .toggleStyle(ButtonToggleStyle())
                    .padding([.horizontal, .bottom])
                    .foregroundColor(Color.primaryColor1)
                }
            }
            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        MenuItemView(dish: dish)
                            .padding(.vertical)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .onAppear() {
            if !isMenuSet{
                getMenuData()
                isMenuSet.toggle()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
            withAnimation {
                self.isKeyboardVisible = true
            }
            
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
            withAnimation {
                self.isKeyboardVisible = false
            }
        }
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let menu = try? decoder.decode(MenuList.self, from: data)
                {
                    for menuItem in menu.menu {
                        let dish = Dish(context: viewContext)
                        dish.title = menuItem.title
                        dish.image = menuItem.image
                        dish.price = menuItem.price
                        dish.dishDescription = menuItem.description
                        dish.category = menuItem.category
                    }
                    try? viewContext.save()
                }
            }
        }
        task.resume()
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare))]
    }
    
    func buildPredicate() -> NSCompoundPredicate {
        let search = searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        
        let starters = !isStarters ? NSPredicate(format: "category != %@", "starters") : NSPredicate(value: true)
        let mains = !isMains ? NSPredicate(format: "category != %@", "mains") : NSPredicate(value: true)
        let desserts = !isDesserts ? NSPredicate(format: "category != %@", "desserts") : NSPredicate(value: true)
        let drinks = !isDrinks ? NSPredicate(format: "category != %@", "drinks") : NSPredicate(value: true)
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [search, starters, mains, desserts, drinks])
        return compoundPredicate
    }
    
}

#Preview {
    Menu()
}
