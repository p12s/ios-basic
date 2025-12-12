import Foundation

final class Card: Codable, Equatable {
    let id: String
    let name: String
    let imageName: String
    var isFavorite: Bool
    
    var path: String {
        id + "_" + name
    }
    
    init(id: String, name: String, imageName: String, isFavorite: Bool = false) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.isFavorite = isFavorite
    }
    
    static func makeMock() -> [Card] {
        [
            Card(id: "0000", name: "Deadpool", imageName: "Deadpool"),
            Card(id: "0001", name: "Kill Bill", imageName: "Kill Bill"),
            Card(id: "0010", name: "Old", imageName: "Old"),
            Card(id: "0011", name: "Tesla", imageName: "Tesla"),
            Card(id: "0100", name: "The Avengers", imageName: "The Avengers"),
            Card(id: "0101", name: "The Dark Knight", imageName: "The Dark Knight"),
            Card(id: "0110", name: "The Godfather", imageName: "The Godfather"),
            Card(id: "0111", name: "The Green Knight", imageName: "The Green Knight"),
            Card(id: "1000", name: "The Ice Age Adventures of Buck Wild", imageName: "The Ice Age Adventures of Buck Wild"),
            Card(id: "1001", name: "Vivarium", imageName: "Vivarium"),
        ]
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.id == rhs.id
    }
}

