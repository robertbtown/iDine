//
//  ItemRow.swift
//  iDine
//
//  Created by Frueh Aaron, US-21 on 09.07.19.
//  Copyright © 2019 Robert Magnusson. All rights reserved.
//

import SwiftUI

struct ItemRow: View {
    var item: MenuItem
    @EnvironmentObject var order: Order

    static let colors: [String: Color] = ["D": .orange, "G": .purple, "N": .red, "S": .blue, "V": .green]

    var body: some View {
        NavigationLink(destination: ItemDetail(item: item).environmentObject(order)) {
            HStack {
                Image(item.thumbnailImage)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 3)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(item.name)
                            .font(.headline)

                        if order.favoriteMenuItems.contains(item) {
                            Image(systemName: "star.fill")
                                .imageScale(.small)
                                .foregroundColor(.yellow)
                        } else {
                            Image(systemName: "star")
                                .imageScale(.small)
                                .foregroundColor(Color.gray)
                        }
                    }
                    Text("\(item.price)€")
                        .font(.subheadline)
                }
                
                Spacer()
                
                ForEach(item.restrictions.identified(by: \.self)) { restriction in
                    Text(restriction)
                        .color(.white)
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(5)
                        .background(Self.colors[restriction, default: .black])
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 1))
                }
            }
        }
    }
}

#if DEBUG
struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(item: MenuItem.example)
    }
}
#endif
