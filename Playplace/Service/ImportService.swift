import Foundation
import SwiftData

struct ImportService {
    let imageExtensions = ["jpg", "jpeg", "png", "JPG", "JPEG", "PNG"]
    
    func importLibrary(url: URL, modelContext: ModelContext) {
        let decodedGames: [Game] = Bundle.main.decode(url)
        importLibrary(games: decodedGames, modelContext: modelContext)
    }
    
    func importLibrary(games: [Game], modelContext: ModelContext) {
        do {
            try modelContext.delete(model: Game.self)
            for game in games {
                game.platforms = fetchPlatforms(game: game, modelContext: modelContext)
                modelContext.insert(game)
            }
            try modelContext.save()
        } catch {
            fatalError("Failed to import library: \(error)")
        }
    }
    
    func fetchPlatforms(game: Game, modelContext: ModelContext) -> [Platform] {
        if game.platformIds == nil || game.platformIds!.isEmpty { return [] }
        
        var result: [Platform] = []
        
        let platformIds = game.platformIds!
        let fetched: [Platform] = fetchEntities(ids: platformIds, modelContext: modelContext)
        
        if platformIds.count != fetched.count {
            let fetchedIds = Set(fetched.map { $0.id })
            let newPlatforms: [Platform] = game.platforms?.filter { !fetchedIds.contains($0.id) } ?? []
            result.append(contentsOf: newPlatforms)
        }
        result.append(contentsOf: fetched)
        
        return result
    }
    
    func fetchEntities<T: IdentifiableString & PersistentModel>(ids: [String], modelContext: ModelContext) -> [T] {
        do {
            let predicate = #Predicate<T> { ids.contains($0.id) }
            let descriptor = FetchDescriptor<T>(predicate: predicate)
            return try modelContext.fetch(descriptor)
        } catch {
            return []
        }
    }
    
    func importImages(urls: [URL]) {
        for url in urls {
            var isDir: ObjCBool = false
            FileManager.default.fileExists(atPath: url.path, isDirectory: &isDir)
            
            if isDir.boolValue {
                findAndImportImages(at: url)
            } else {
                importImage(from: url)
            }
        }
    }
    
    func importImage(from url: URL) {
        let fileManager = FileManager.default
        let libraryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("library")
        
        do {
            try fileManager.createDirectory(at: libraryURL, withIntermediateDirectories: true, attributes: nil)
            
            try fileManager.copyItem(at: url, to: libraryURL.appendingPathComponent(url.lastPathComponent))
        } catch {
            fatalError("Error importing image: \(error)")
        }
    }
    
    private func findAndImportImages(at directory: URL) {
        do {
            let files = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
            
            for file in files {
                if file.hasDirectoryPath {
                    findAndImportImages(at: file)
                } else if imageExtensions.contains(file.pathExtension) {
                    importImage(from: file)
                }
            }
        } catch {
            fatalError("Error while enumerating files: \(error.localizedDescription)")
        }
    }
}
