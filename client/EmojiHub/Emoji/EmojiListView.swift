//
//  EmojiListView.swift
//  EmojiHub
//
//  Created by Арайлым Кабыкенова on 28.04.2025.
//


import SwiftUI

struct EmojiListView: View {
    @StateObject private var viewModel = EmojiListViewModel()
    @State private var isShowingFavorites = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Поиск эмодзи", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Picker("Сортировка", selection: $viewModel.sortOption) {
                    Text("По имени").tag(SortOption.name)
                    Text("По категории").tag(SortOption.category)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                Picker("Стиль отображения", selection: $viewModel.displayStyle) {
                    Text("Unicode").tag(DisplayStyle.unicode)
                    Text("HTML Code").tag(DisplayStyle.htmlCode)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                Group {
                    if viewModel.isLoading {
                        ProgressView("Загрузка эмодзи...")
                        Spacer()
                    } else if let errorMessage = viewModel.errorMessage {
                        Text("Ошибка: \(errorMessage)")
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Spacer()
                    } else {
                        List(viewModel.sortedEmojis) { emoji in
                            HStack {
                                Button(action: {
                                    viewModel.toggleFavorite(for: emoji)
                                }) {
                                    Image(systemName: viewModel.isFavorite(emoji) ? "heart.fill" : "heart")
                                        .foregroundColor(viewModel.isFavorite(emoji) ? .red : .gray)
                                }

                                Text(viewModel.displayStyle == .unicode
                                     ? (emoji.unicode?.compactMap { unicodeToEmoji($0) }.joined() ?? "")
                                     : (emoji.htmlCode?.compactMap { htmlCodeToString($0) }.joined(separator: " ") ?? ""))
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
            }
            .onAppear {
                viewModel.fetchEmojis()
            }
            .navigationTitle("Каталог эмодзи")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingFavorites = true
                    }) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    }
                    .sheet(isPresented: $isShowingFavorites) {
                        FavoritesView(favoriteEmojis: viewModel.favoriteEmojis.map { emojiName in
                            viewModel.emojis.first { $0.name == emojiName }!
                        })
                    }
                }
            }
        }
    }
}


extension EmojiListView {
    private func htmlCodeToString(_ htmlCode: String) -> String {
        let pattern = #"&#(\d+);"#
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(in: htmlCode, range: NSRange(htmlCode.startIndex..., in: htmlCode)),
              let range = Range(match.range(at: 1), in: htmlCode) else {
            return htmlCode
        }
        
        let numberString = String(htmlCode[range])
        
        if let number = Int(numberString),
           let scalar = UnicodeScalar(number) {
            return String(scalar)
        }
        
        return htmlCode
    }
    
    private func unicodeToEmoji(_ unicode: String) -> String {
        let scalars = unicode.split(separator: "U+").compactMap { UInt32($0, radix: 16) }.compactMap { UnicodeScalar($0) }
        return String(String.UnicodeScalarView(scalars))
    }
}
