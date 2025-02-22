import Foundation

extension Bundle {
    public func decode<T: Codable>(_ file: String) -> T {
        do {
            guard let url = url(forResource: file, withExtension: nil) else {
                fatalError("Fail to load \(file) in bundle")
            }
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription), errorDesc: \(error)")
        }
    }
    
    public func decode<T: Codable>(_ url: URL) -> T {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Failed to decode \(url) from bundle: \(error.localizedDescription), errorDesc: \(error)")
        }
    }
}
