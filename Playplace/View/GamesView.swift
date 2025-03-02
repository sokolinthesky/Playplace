import SwiftData
import SwiftUI

struct GamesView: View {
    let importService = ImportService()
    
    let layout = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    @Environment(\.modelContext) var modelContext
    
    @State private var importingLibrary = false
    @State private var importingImages = false
    @State private var exportingLibrary = false
    @State private var showAddGameView = false
    
    @Query var games: [Game]
    
    var body: some View {
        LazyVGrid(columns: layout) {
            ForEach(games, id: \.id) { game in
                NavigationLink(value: game) {
                    GameView(game: game)
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                
                Button("Import") {
                    importingLibrary.toggle()
                }
                .fileImporter(
                    isPresented: $importingLibrary,
                    allowedContentTypes: [.json]
                ) { result in
                    switch result {
                    case .success(let url):
                        importService.importLibrary(url: url, modelContext: modelContext)
                    case .failure(let error):
                        fatalError("Error importing file: \(error.localizedDescription)")
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
                        importService.importImages(urls: urls)
                    case .failure(let error):
                        fatalError("Error importing media file: \(error.localizedDescription)")
                    }
                }
                
                Button("Export") {
                    exportingLibrary.toggle()
                }
                .fileExporter(
                    isPresented: $exportingLibrary,
                    document: createJSONDocument(),
                    contentType: .json,
                    defaultFilename: "games"
                ) { result in
                    switch result {
                    case .success(let url):
                        print("Library exported to: \(url)")
                    case .failure(let error):
                        fatalError("Error saving file: \(error)")
                    }
                }
                
                Button("Add game", systemImage: "plus") { showAddGameView.toggle() }
            }
        }
        .sheet(isPresented: $showAddGameView) {
            AddGameView()
        }
    }
    
    init(sortOrder: [SortDescriptor<Game>]) {
        _games = Query(sort: sortOrder)
    }
    
    func createJSONDocument() -> JSONDocument {
        do {
            let jsonData = try JSONEncoder().encode(games)
            return JSONDocument(data: jsonData)
        } catch {
            fatalError("unable to create JSON document: \(error)")
        }
    }
}

#Preview {
    GamesView(sortOrder: [SortDescriptor(\Game.name)])
        .modelContainer(for: Game.self)
}
