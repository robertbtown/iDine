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

    static let colors: [String: Color] = ["D": .orange, "G": .purple, "N": .red, "S": .blue, "V": .green]

    var body: some View {
        HStack {
            Image(item.thumbnailImage)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 3)

            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
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

#if DEBUG
struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(item: MenuItem.example)
    }
}
#endif
