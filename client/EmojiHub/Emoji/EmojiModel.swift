//
//  Emoji.swift
//  EmojiHub
//
//  Created by Арайлым Кабыкенова on 28.04.2025.
//


import Foundation

enum SortOption {
    case name
    case category
}

enum DisplayStyle {
    case unicode
    case htmlCode
}

struct Emoji: Codable, Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let group: String
    let htmlCode: [String]?
    let unicode: [String]?
}
