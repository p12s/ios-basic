import Foundation

protocol IStorageService {
    func create(from model: Card, at key: String) -> Bool
    func read(for key: String) -> [Card]
    func delete(model: Card, at key: String) -> Bool
}

