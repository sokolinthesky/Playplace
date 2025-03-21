import Foundation
import SwiftUI

struct GameView: View {
    @Bindable var game: Game
    
    @State var coverName = ""
    @State private var cover: Image = Image("default-cover")
    
    var body: some View {
        VStack {
            cover
                .resizable()
                .scaledToFill()
                .frame(width: 124, height: 170)
                .cornerRadius(10)
                .shadow(radius: 5)
                .overlay {
                    Text(coverName)
                        .foregroundStyle(.white)
                }
            
        }
        .onAppear {
            Task {
                await loadImage(game: game)
            }
        }
    }
    
    init(game: Game) {
        self.game = game
    }
    
    func loadImage(game: Game) async {
        if game.coverImage != nil && !game.coverImage!.isEmpty {
            let imagePath = game.coverImage?.components(separatedBy: "\\") ?? []
            let imageFilename = imagePath.last ?? ""
            if !imageFilename.isEmpty {
                let imageURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    .appendingPathComponent("library/\(imageFilename)")
                if let data = try? Data(contentsOf: imageURL), let uiImage = UIImage(data: data) {
                    cover = Image(uiImage: uiImage)
                    return
                }
            }
        }
        self.coverName = game.name ?? "No Name"
    }
}

#Preview {
    GameView(game: Game(imageCover: "folder\\3088156708.jpg"))
}
