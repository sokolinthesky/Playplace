import SwiftData
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                GamesView(sortOrder: [SortDescriptor(\Game.name)])
            }
            .navigationDestination(for: Game.self) { game in
                GameDetailView(game: game)
            }
        }
    }
}

#Preview {
    ContentView()
}
