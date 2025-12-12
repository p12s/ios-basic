import Foundation

final class FileManagerService {
    private let directory: FileManager.SearchPathDirectory
    private let mask: FileManager.SearchPathDomainMask
    
    private var directoryUrl: URL?
    
    private lazy var encoder: JSONEncoder = JSONEncoder()
    private lazy var decoder: JSONDecoder = JSONDecoder()
    
    init(
        directory: FileManager.SearchPathDirectory = .documentDirectory,
        mask: FileManager.SearchPathDomainMask = .userDomainMask
    ) {
        self.directory = directory
        self.mask = mask
        directoryUrl = FileManager.default.urls(for: directory, in: mask).first
    }
}

extension FileManagerService: IStorageService {
    func create(from model: Card, at key: String) -> Bool {
        do {
            guard var directoryUrl else { return false }
            
            directoryUrl.appendPathComponent(key)
            
            if !FileManager.default.fileExists(atPath: directoryUrl.path) {
                try FileManager.default.createDirectory(
                    at: directoryUrl,
                    withIntermediateDirectories: true
                )
            }
            
            directoryUrl.appendPathComponent(model.path)
            directoryUrl.appendPathExtension("json")
            
            let data = try encoder.encode(model)
            try data.write(to: directoryUrl)
            
            return true
        } catch {
            return false
        }
    }
    
    func read(for key: String) -> [Card] {
        guard var directoryUrl else { return [] }
        
        directoryUrl.appendPathComponent(key)
        
        guard FileManager.default.fileExists(atPath: directoryUrl.path) else {
            return []
        }
        
        do {
            let files = try FileManager.default.contentsOfDirectory(at: directoryUrl, includingPropertiesForKeys: nil)
            let jsonFiles = files.filter { $0.pathExtension == "json" }
            
            var cards: [Card] = []
            for file in jsonFiles {
                let data = try Data(contentsOf: file)
                let card = try decoder.decode(Card.self, from: data)
                cards.append(card)
            }
            
            return cards
        } catch {
            return []
        }
    }
    
    func delete(model: Card, at key: String) -> Bool {
        guard var directoryUrl else { return false }
        
        directoryUrl.appendPathComponent(key)
        directoryUrl.appendPathComponent(model.path)
        directoryUrl.appendPathExtension("json")
        
        guard FileManager.default.fileExists(atPath: directoryUrl.path) else {
            return false
        }
        
        do {
            try FileManager.default.removeItem(at: directoryUrl)
            return true
        } catch {
            return false
        }
    }
}

