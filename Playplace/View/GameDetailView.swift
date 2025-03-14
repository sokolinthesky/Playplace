import SwiftUI

struct GameDetailView: View {
    var game: Game
    
    var body: some View {
        ScrollView {
            VStack {
                GameView(game: game)
                
                PlayTimeView(hoursMinutes: convertSecondsToHoursAndMinutes(seconds: game.playtime ?? 0))
                    .leftAligned()
                
                Text("Platforms")
                    .leftAligned()
                    .font(.headline)
                PlatformsView(selectedPlatforms: Set(game.platforms ?? []))
                    
                
                Text("Description")
                    .font(.headline)
                    .leftAligned()
                Text("\(game.desc ?? "no description")").leftAligned()
            }
            .padding()
            
        }
        .navigationTitle(gameName(game: game))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func convertSecondsToHoursAndMinutes(seconds: Int) -> (hours: Int, minutes: Int) {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        return (hours, minutes)
    }
    
    func gameName(game: Game) -> String {
        return game.name ?? "no name"
    }
}

struct PlayTimeView : View {
    var hoursMinutes: (hours: Int, minutes: Int)
    
    var body: some View {
        HStack {
            Text("Playtime:")
            Text("\(hoursMinutes.hours)h \(hoursMinutes.minutes)m")
                .foregroundColor(.green)
        }
        .foregroundStyle(.primary)
        .font(.headline)
    }
}

struct LeftAligned: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension View {
    func leftAligned() -> some View {
        self.modifier(LeftAligned())
    }
}

#Preview {
    do {
        let example = Game(imageCover: "3088156708")
        example.name = "Grand Theft Auto V"
        example.platforms = [
            Platform(id: UUID().uuidString, name: "PlayStation 4"),
            Platform(id: UUID().uuidString, name: "PlayStation 5"),
            Platform(id: UUID().uuidString, name: "Xbox One"),
            Platform(id: UUID().uuidString, name: "Xbox Series X/S")
        ]
        example.playtime = 86000
        example.desc = "Satirical portrayal of American culture"
        
        return GameDetailView(game: example)
            .preferredColorScheme(.dark)
    } catch {
        return Text("")
    }
}
