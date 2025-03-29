import Foundation
import SwiftUI

struct GameView: View {
    @Bindable var game: Game
    
    @State private var coverName = ""
    @State private var isCoverImagedLoaded = false
    @State private var cover: Image = Image("default-cover")
    
    var body: some View {
        VStack {
            cover
                .resizable()
                .scaledToFill()
                .frame(width: 124, height: 170)
                .shadow(radius: 5)
                .overlay {
                    if !isCoverImagedLoaded {
                        Text(coverName)
                            .foregroundStyle(.white)
                    }
                }
            
        }
        .onAppear {
            loadImage(game: game)
        }
    }
    
    init(game: Game) {
        self.game = game
    }
    
    func loadImage(game: Game) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.coverName = game.name ?? "No Name"
            
            if game.coverImage == nil || game.coverImage!.isEmpty {
                return
            }
            
            let imageFilename = game.coverImage!.localizedStandardContains("\\") ?
            game.coverImage!.components(separatedBy: "\\").last! : game.coverImage!
            
            if imageFilename.isEmpty {
                return
            }
            
            let imageURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                .appendingPathComponent("library/\(imageFilename)")
            if let data = try? Data(contentsOf: imageURL), let uiImage = UIImage(data: data) {
                let resizedImage = resizeImage(image: uiImage, targetSize: CGSize(width: 300, height: 300))
                cover = Image(uiImage: resizedImage)
                isCoverImagedLoaded = true
            }
        }
    }
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Determine what ratio to use to ensure the image fits within the target size
        let ratio = min(widthRatio, heightRatio)
        
        // Calculate the new size
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        
        // Resize the image
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? image
    }
}

#Preview {
    GameView(game: Game(imageCover: "folder\\3088156708.jpg"))
}
