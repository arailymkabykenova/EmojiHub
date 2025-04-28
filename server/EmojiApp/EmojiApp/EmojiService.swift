import Foundation

// Defines potential errors during fetching
enum NetworkError: Error {
    case badURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
}

// An object responsible for fetching emojis
class EmojiService: ObservableObject {
    // @Published automatically tells SwiftUI views to refresh when this array changes.
    @Published var emojis: [Emoji] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    let backendURL = URL(string: "https://emojiapp.onrender.com/emojis/") // Your backend URL

    // Function to fetch emojis asynchronously
    @MainActor // Ensures UI updates happen on the main thread
    func fetchEmojis() async {
        guard let url = backendURL else {
            errorMessage = "Invalid backend URL"
            print("Error: Invalid backend URL")
            return
        }

        isLoading = true // Show loading indicator (we'll add UI later)
        errorMessage = nil // Clear previous errors

        do {
            // 1. Perform the network request
            let (data, response) = try await URLSession.shared.data(from: url)

            // 2. Check the response status code (e.g., 200 OK)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                isLoading = false
                errorMessage = "Invalid server response."
                print("Error: Invalid server response - Status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                return
            }

            // 3. Decode the JSON data into our [Emoji] array
            let decoder = JSONDecoder()
            // Use this if your JSON keys are snake_case (like 'html_code') but your Swift properties are camelCase (like 'htmlCode')
            // decoder.keyDecodingStrategy = .convertFromSnakeCase
            let fetchedEmojis = try decoder.decode([Emoji].self, from: data)

            // 4. Update the published array on the main thread
            self.emojis = fetchedEmojis
            self.isLoading = false
            print("Successfully fetched \(fetchedEmojis.count) emojis.")

        } catch let error as DecodingError {
            isLoading = false
            errorMessage = "Failed to decode JSON: \(error.localizedDescription)"
            print("Decoding Error: \(error)") // Print detailed decoding error
            // You might want to print the raw data string here to debug JSON structure mismatches
            // print("Raw data: \(String(data: data, encoding: .utf8) ?? "Could not print data")")
        } catch {
            isLoading = false
            errorMessage = "Request failed: \(error.localizedDescription)"
            print("Network Error: \(error)")
        }
    }
}
