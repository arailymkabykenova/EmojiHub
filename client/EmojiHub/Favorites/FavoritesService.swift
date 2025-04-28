//
//  FavoritesService.swift
//  EmojiHub
//
//  Created by Арайлым Кабыкенова on 28.04.2025.
//


import Foundation

class FavoritesService {
    private let favoritesKey = "favoriteEmojis"

    func getFavorites() -> [String] {
        UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
    }

    func addToFavorites(_ emojiName: String) {
        var favorites = getFavorites()
        if !favorites.contains(emojiName) {
            favorites.append(emojiName)
            UserDefaults.standard.set(favorites, forKey: favoritesKey)
        }
    }

    func removeFromFavorites(_ emojiName: String) {
        var favorites = getFavorites()
        if let index = favorites.firstIndex(of: emojiName) {
            favorites.remove(at: index)
            UserDefaults.standard.set(favorites, forKey: favoritesKey)
        }
    }

    func isFavorite(_ emojiName: String) -> Bool {
        getFavorites().contains(emojiName)
    }
}
