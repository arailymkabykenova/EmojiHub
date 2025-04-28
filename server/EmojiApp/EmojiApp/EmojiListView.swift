import SwiftUI

struct EmojiListView: View {
    @StateObject private var emojiService = EmojiService()
    // State variable to hold the user's search input
    @State private var searchText = ""
    // State variable to hold the selected sort order
    @State private var sortOrder: SortOrder = .none // Default sort

    // Enum to define sorting options
    enum SortOrder: String, CaseIterable, Identifiable {
        case none = "Default" // No sorting / As received
        case alphabetical = "A-Z"
        case category = "Category"
        var id: String { self.rawValue }
    }

    var body: some View {
        VStack { // Use VStack to hold List and potentially other controls later
            // Display loading indicator or error message
            if emojiService.isLoading {
                ProgressView("Loading Emojis...") // Shows a spinner
                    .padding()
            } else if let errorMessage = emojiService.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            }

            // The List that displays emojis
            List(filteredAndSortedEmojis) { emoji in
                // Each row in the list
                HStack {
                    Text(emoji.emojiCharacter) // Display the emoji character itself
                        .font(.largeTitle) // Make emoji bigger
                    VStack(alignment: .leading) { // Align text to the left
                        Text(emoji.name.capitalized) // Capitalize the name
                            .font(.headline)
                        Text("Category: \(emoji.category)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        // Add description if you have it in your Emoji model
                        // if let description = emoji.description {
                        //     Text(description)
                        //         .font(.caption)
                        //         .foregroundColor(.secondary)
                        // }
                    }
                }
            }
            // Add the search bar using the searchable modifier (iOS 15+)
            .searchable(text: $searchText, prompt: "Search by name")
            // Add sorting controls to the toolbar
            .toolbar {
                ToolbarItem(placement: .automatic) { // <= исправили тут
                    Picker("Sort By", selection: $sortOrder) {
                        ForEach(SortOrder.allCases) { order in
                            Text(order.rawValue).tag(order)
                        }
                    }
                    .pickerStyle(.menu) // Use a dropdown menu style
                }
            }

        } // End of VStack
        .navigationTitle("Emojis")
        .onAppear {
            if emojiService.emojis.isEmpty {
                Task {
                    await emojiService.fetchEmojis()
                }
            }
        }
    } // End of body

    // Computed property to handle filtering AND sorting
    var filteredAndSortedEmojis: [Emoji] {
        // 1. Filter based on search text
        let filtered: [Emoji]
        if searchText.isEmpty {
            filtered = emojiService.emojis // No search text, show all
        } else {
            filtered = emojiService.emojis.filter { emoji in
                // Check if name contains search text (case-insensitive)
                emoji.name.lowercased().contains(searchText.lowercased())
            }
        }

        // 2. Sort the filtered results
        switch sortOrder {
        case .none:
            return filtered // No sorting, return as is
        case .alphabetical:
            // Sort by name, alphabetically
            return filtered.sorted { $0.name < $1.name }
        case .category:
            // Sort primarily by category, then by name within each category
            return filtered.sorted {
                if $0.category != $1.category {
                    return $0.category < $1.category // Sort by category first
                } else {
                    return $0.name < $1.name // Then by name if categories are the same
                }
            }
        }
    }
} // End of struct

// Preview remains the same
struct EmojiListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EmojiListView()
        }
    }
}
