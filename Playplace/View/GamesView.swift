import SwiftData
import SwiftUI

struct GamesView: View {
    
    let layout = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    @Query var games: [Game]
    
    var body: some View {
        LazyVGrid(columns: layout) {
            ForEach(games, id: \.id) { game in
                NavigationLink(value: game) {
                    GameView(game: game)
                }
            }
        }
    }
    
    init(sortOrder: [SortDescriptor<Game>]) {
        _games = Query(sort: sortOrder)
    }
}

#Preview {
    GamesView(sortOrder: [SortDescriptor(\Game.name)])
        .modelContainer(for: Game.self)
}
