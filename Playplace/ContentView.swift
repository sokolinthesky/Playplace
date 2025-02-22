import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var importing = false
    @State private var importingMedia = false
    
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
                        importing = true
                    }
                    .fileImporter(
                        isPresented: $importing,
                        allowedContentTypes: [.json]
                    ) { result in
                        switch result {
                        case .success(let url):
                            importLibrary(url: url)
                        case .failure(let error):
                            print("Error importing file: \(error.localizedDescription)")
                        }
                    }
                    
                    Button("Import Image") {
                        importingMedia.toggle()
                    }
                    .fileImporter(
                        isPresented: $importingMedia,
                        allowedContentTypes: [.image],
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
            let gamesToLoad: [Game] = Bundle.main.decode(url)
            try modelContext.delete(model: Game.self)
            for game in gamesToLoad {
                modelContext.insert(game)
            }
            try modelContext.save()
        } catch {
            fatalError("Failed to import library: \(error)")
        }
    }
    
    func importImages(urls: [URL]) {
        for url in urls {
            importImage(url)
        }
    }
    
    func importImage(_ url: URL) {
        let fileManager = FileManager.default
        let libraryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("library")
        
        do {
            try fileManager.createDirectory(at: libraryURL, withIntermediateDirectories: true, attributes: nil)

            try fileManager.copyItem(at: url, to: libraryURL.appendingPathComponent(url.lastPathComponent))
            print("Image imported to: \(libraryURL)")
        } catch {
            print("Error importing image: \(error)")
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
