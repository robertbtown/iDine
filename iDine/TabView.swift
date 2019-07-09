//
//  TabView.swift
//  iDine
//
//  Created by Frueh Aaron, US-21 on 09.07.19.
//  Copyright © 2019 Robert Magnusson. All rights reserved.
//

import SwiftUI

struct TabView : View {
    var body: some View {
        TabbedView {
            ContentView()
                .tabItem {
                    VStack {
                        Image("system-list")
                        Text("Menu")
                    }
                }.tag(0)

            OrderView()
                .tabItem {
                    VStack {
                        Image("system-compose")
                        Text("Order")
                    }
                }.tag(1)
        }
    }
}

#if DEBUG
struct TabView_Previews : PreviewProvider {
    static let order = Order()
    static var previews: some View {
        TabView()
    }
}
#endif
