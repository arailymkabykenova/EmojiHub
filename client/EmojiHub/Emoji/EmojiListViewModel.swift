//
//  EmojiListViewModel.swift
//  EmojiHub
//
//  Created by Арайлым Кабыкенова on 28.04.2025.
//


import Foundation

class EmojiListViewModel: ObservableObject {
    @Published var emojis: [Emoji] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .name
    @Published var favoriteEmojis: Set<String> = []
    @Published var displayStyle: DisplayStyle = .unicode

    private let emojiService = EmojiService()
    private let favoritesService = FavoritesService()
    private var hasFetched = false

    var filteredEmojis: [Emoji] {
        if searchText.isEmpty {
            return emojis
        } else {
            return emojis.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    var sortedEmojis: [Emoji] {
        let filtered = filteredEmojis
        switch sortOption {
        case .name:
            return filtered.sorted { $0.name < $1.name }
        case .category:
            return filtered.sorted { $0.category < $1.category }
        }
    }

    func fetchEmojis() {
        guard !hasFetched else { return }
        hasFetched = true

        isLoading = true
        errorMessage = nil

        emojiService.fetchEmojis { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let emojis):
                    self?.emojis = emojis
                    self?.loadFavorites()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func toggleFavorite(for emoji: Emoji) {
        if favoriteEmojis.contains(emoji.name) {
            favoriteEmojis.remove(emoji.name)
            favoritesService.removeFromFavorites(emoji.name)
        } else {
            favoriteEmojis.insert(emoji.name)
            favoritesService.addToFavorites(emoji.name)
        }
    }

    func loadFavorites() {
        favoriteEmojis = Set(favoritesService.getFavorites())
    }

    func isFavorite(_ emoji: Emoji) -> Bool {
        favoriteEmojis.contains(emoji.name)
    }
}
