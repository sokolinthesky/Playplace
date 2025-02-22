import SwiftData
import SwiftUI

@main
struct PlayplaceApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Game.self)
        
    }
}
