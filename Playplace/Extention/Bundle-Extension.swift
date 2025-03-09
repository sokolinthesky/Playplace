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
    
    public func getDropboxAppKey() -> String? {
        if let urlTypes = Bundle.main.object(forInfoDictionaryKey: "CFBundleURLTypes") as? [[String: Any]] {
            for urlType in urlTypes {
                if let urlSchemes = urlType["CFBundleURLSchemes"] as? [String] {
                    for urlScheme in urlSchemes {
                        if urlScheme.hasPrefix("db-") {
                            return urlScheme.replacingOccurrences(of: "db-", with: "")
                        }
                    }
                }
            }
        }
        return nil
    }
}
