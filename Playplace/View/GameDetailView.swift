import SwiftUI

struct GameDetailView: View {
    var game: Game
    
    var body: some View {
        Text(game.name!)
    }
}

#Preview {
    GameDetailView(game: Game(imageCover: "br"))
}
