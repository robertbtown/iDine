//
//  ItemDetail.swift
//  iDine
//
//  Created by Robert Magnusson on 09.07.19.
//  Copyright © 2019 Robert Magnusson. All rights reserved.
//

import SwiftUI

struct ItemDetail : View {
    var item: MenuItem
    @EnvironmentObject var order: Order

    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(item.mainImage)
                Text("Photo: \(item.photoCredit)")
                    .padding(4)
                    .background(Color.black.opacity(0.6))
                    .font(.caption)
                    .foregroundColor(.white)
                    .cornerRadius(4)
                    .offset(x: -5, y: -5)
            }

            Text(item.description)
                .lineLimit(nil)
                .padding()

            Button(action: {
                if !self.order.containsFavourite(item: self.item) {
                    self.order.addFavourite(item: self.item)
                } else {
                    self.order.removeFavourite(item: self.item)
                }
            }) {
                if !self.order.containsFavourite(item: self.item) {
                    Text("Add to Favourites").font(.headline)
                } else {
                    Text("Remove from Favourites").font(.headline)
                }
            }.padding()

            Button(action: {
                self.order.add(item: self.item)
            }) {
                Text("Order now")
                    .font(.headline)
            }.padding()
            Spacer()
        }
        .navigationBarTitle(Text(item.name), displayMode: .inline)
    }
}

#if DEBUG
struct ItemDetail_Previews : PreviewProvider {
    static let order = Order()

    static var previews: some View {
        NavigationView {
            ItemDetail(item: MenuItem.example)
                .environmentObject(order)
        }
    }
}
#endif
