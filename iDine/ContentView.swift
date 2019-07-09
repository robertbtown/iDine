//
//  ContentView.swift
//  iDine
//
//  Created by Robert Magnusson on 09.07.19.
//  Copyright © 2019 Robert Magnusson. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")

    @EnvironmentObject var order: Order
    @State private var filterFavourites: Bool = false

    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $filterFavourites.animation()) {
                    Text("Filter Favourites")
                }

                ForEach (menu) { section in
                    if !self.filterFavourites || section.items.filter({ self.order.containsFavourite(item: $0) }).count > 0 {
                        Section(header: Text(section.name)) {
                            ForEach (section.items) { item in
                                if !self.filterFavourites || self.order.containsFavourite(item: item) {
                                    ItemRow(item: item)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Menu")
            .listStyle(.grouped)
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
