import SwiftData
import SwiftUI
import SwiftyDropbox
import os

@main
struct PlayplaceApp: App {
    let log = Logger()
    
    init() {
        initDropbox()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: Game.self)
        
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
