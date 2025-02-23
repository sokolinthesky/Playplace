import SwiftData
import SwiftUI

struct ContentView: View {
    let imageExtensions = ["jpg", "jpeg", "png", "JPG", "JPEG", "PNG"]
    
    @Environment(\.modelContext) var modelContext
    @State private var importingLibrary = false
    @State private var importingImages = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                GamesView(sortOrder: [SortDescriptor(\Game.name)])
            }
            .navigationDestination(for: Game.self) { game in
                GameDetailView(game: game)
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    
                    Button("Import") {
                        importingLibrary = true
                    }
                    .fileImporter(
                        isPresented: $importingLibrary,
                        allowedContentTypes: [.json]
                    ) { result in
                        switch result {
                        case .success(let url):
                            importLibrary(url: url)
                        case .failure(let error):
                            print("Error importing file: \(error.localizedDescription)")
                        }
                    }
                    
                    Button("Import images") {
                        importingImages.toggle()
                    }
                    .fileImporter(
                        isPresented: $importingImages,
                        allowedContentTypes: [.folder, .image],
                        allowsMultipleSelection: true
                    ) { result in
                        switch result {
                        case .success(let urls):
                            importImages(urls: urls)
                        case .failure(let error):
                            print("Error importing media file: \(error.localizedDescription)")
                        }
                    }
                    
                    Button("Export") {
                        //todo
                    }
                }
                
            }
        }
    }
    
    func importLibrary(url: URL) {
        do {
            let decodedGames: [Game] = Bundle.main.decode(url)
            try modelContext.delete(model: Game.self)
            for game in decodedGames {
                modelContext.insert(game)
            }
            try modelContext.save()
        } catch {
            fatalError("Failed to import library: \(error)")
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

#Preview {
    //    do {
    //        let config = ModelConfiguration(isStoredInMemoryOnly: true)
    //        let container = try ModelContainer(for: Game.self, configurations: config)
    //        let games = Bundle.main.decode("games.json");
    //        return ContentView(games: games)
    //            .modelContainer(container)
    //    } catch {
    //        return Text("Error: \(error)")
    //    }
    ContentView()
}
