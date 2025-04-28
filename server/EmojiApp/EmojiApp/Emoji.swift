import Foundation

struct Emoji: Codable, Identifiable {
    let id: String
    let name: String
    let category: String
    let group: String
    let htmlCode: [String]
    let unicode: [String]
    
    // получаем красивый эмодзи
    var emojiCharacter: String {
        if let htmlCodeString = htmlCode.first {
            return htmlCodeString.decodeHtmlEntities()
        } else {
            return "❓"
        }
    }
}

//  расширение для декодирования
extension String {
    func decodeHtmlEntities() -> String {
        guard let data = self.data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html
        ]
        if let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            return attributedString.string
        } else {
            return self
        }
    }
}
