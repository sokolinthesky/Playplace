import SwiftData
import SwiftUI
import SwiftyDropbox
import os

@main
struct PlayplaceApp: App {
    let log = Logger()
    let modelContainer: ModelContainer
    
    init() {
        do {
            self.modelContainer = try ModelContainer(for: Game.self)
        } catch {
            fatalError("Error to init model container")
        }
        initDropbox()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(modelContext: modelContainer.mainContext)
                .preferredColorScheme(.dark)
        }
        
    }
    
    private func initDropbox() {
        guard let key = Bundle.main.getDropboxAppKey() else {
            log.warning("Dropbox not initialized")
            return
        }
        DropboxClientsManager.setupWithAppKey(key)
        log.info("Dropbox initialized")
    }
}
