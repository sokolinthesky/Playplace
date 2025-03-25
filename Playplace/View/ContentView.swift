import SwiftData
import SwiftUI

struct ContentView: View {
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    var body: some View {
        NavigationStack {
            GamesView(modelContext: modelContext)
                .navigationDestination(for: Game.self) { game in
                    GameDetailView(game: game)
                }
                .navigationTitle("Library")
                .navigationBarTitleDisplayMode(.inline)
            }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Game.self, configurations: config)
        
        return ContentView(modelContext: container.mainContext)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
