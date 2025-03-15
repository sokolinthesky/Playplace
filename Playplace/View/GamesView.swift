import SwiftData
import SwiftUI

struct GamesView: View {
    let layout = [
        GridItem(.adaptive(minimum: 120))
    ]
    
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
        .padding([.horizontal], 1)
    }
    
    init(searchText: String, sortOrder: [SortDescriptor<Game>]) {
        _games = Query(filter: #Predicate<Game> { game in
            if searchText.isEmpty {
                return true
            } else {
                return game.name?.localizedStandardContains(searchText) ?? false
            }
        }, sort: sortOrder)
    }
}

#Preview {
    GamesView(searchText: "", sortOrder: [SortDescriptor(\Game.name)])
        .modelContainer(for: Game.self)
}
