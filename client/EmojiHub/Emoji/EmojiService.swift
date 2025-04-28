//
//  EmojiService.swift
//  EmojiHub
//
//  Created by Арайлым Кабыкенова on 28.04.2025.
//


import Foundation

class EmojiService {
    private let baseURL = "https://emojiapp.onrender.com/emojis/"

    func fetchEmojis(completion: @escaping (Result<[Emoji], Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }

            if let jsonString = String(data: data, encoding: .utf8) {
            }

            do {
                let emojis = try JSONDecoder().decode([Emoji].self, from: data)
                print("Successfully decoded \(emojis.count) emojis")
                completion(.success(emojis))
            } catch {
                print("JSON decoding error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
}
