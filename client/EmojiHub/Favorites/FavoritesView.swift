//
//  FavoritesView.swift
//  EmojiHub
//
//  Created by Арайлым Кабыкенова on 28.04.2025.
//


import SwiftUI

struct FavoritesView: View {
    let favoriteEmojis: [Emoji] 

    var body: some View {
        VStack {
            if favoriteEmojis.isEmpty {
                
                Text("Нет избранных эмодзи")
                    .font(.title)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                Capsule()
                    .foregroundColor(.gray)
                    .frame(width: 40, height: 5)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                
                List(favoriteEmojis) { emoji in
                    HStack {
                        
                        Text(emoji.unicode?.compactMap { unicodeToEmoji($0) }.joined() ?? "")
                            .font(.largeTitle)

                        VStack(alignment: .leading) {
                            Text(emoji.name)
                                .font(.headline)
                            Text(emoji.category)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .navigationTitle("Избранное")
    }

    private func unicodeToEmoji(_ unicode: String) -> String {
        let scalars = unicode.split(separator: "U+").compactMap { UInt32($0, radix: 16) }.compactMap { UnicodeScalar($0) }
        return String(String.UnicodeScalarView(scalars))
    }
}
