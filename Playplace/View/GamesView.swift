import SwiftData
import SwiftUI
import SwiftyDropbox
import os

struct GamesView: View {
    let logger = Logger()
    
    let importService = ImportService()
    
    let layout = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    @Environment(\.modelContext) var modelContext
    
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
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                
                Button("Import") {
                    importingLibrary.toggle()
                }
                .fileImporter(
                    isPresented: $importingLibrary,
                    allowedContentTypes: [.json]
                ) { result in
                    switch result {
                    case .success(let url):
                        importService.importLibrary(url: url, modelContext: modelContext)
                    case .failure(let error):
                        fatalError("Error importing file: \(error.localizedDescription)")
                    }
                }
                
                Button("Images") {
                    importingImages.toggle()
                }
                .fileImporter(
                    isPresented: $importingImages,
                    allowedContentTypes: [.folder, .image],
                    allowsMultipleSelection: true
                ) { result in
                    switch result {
                    case .success(let urls):
                        importService.importImages(urls: urls)
                    case .failure(let error):
                        fatalError("Error importing media file: \(error.localizedDescription)")
                    }
                }
                
                Button("Export") {
                    exportingLibrary.toggle()
                }
                .fileExporter(
                    isPresented: $exportingLibrary,
                    document: createJSONDocument(),
                    contentType: .json,
                    defaultFilename: "games"
                ) { result in
                    switch result {
                    case .success(let url):
                        logger.info("Library exported to: \(url)")
                    case .failure(let error):
                        fatalError("Error saving file: \(error)")
                    }
                }
                
                Button("Add game", systemImage: "plus") { showAddGameView.toggle() }
                
                Button("DP login") {
                    performLogin()
                }
                .onOpenURL { url in
                    let oauthCompletion: DropboxOAuthCompletion = {
                        if let authResult = $0 {
                            switch authResult {
                            case .success:
                                logger.info("Success! User is logged into DropboxClientsManager.")
                            case .cancel:
                                logger.warning("Authorization flow was manually canceled by user!")
                            case .error(_, let description):
                                logger.error("Error: \(String(describing: description))")
                            }
                        }
                    }
                    DropboxClientsManager.handleRedirectURL(url, backgroundSessionIdentifier: "pp-dpb-session", completion: oauthCompletion)
                }
                
                Button("DP upload") {
                    uploadLibraryToDropbox()
                }
            }
        }
        .sheet(isPresented: $showAddGameView) {
            AddGameView()
        }
    }
    
    init(sortOrder: [SortDescriptor<Game>]) {
        _games = Query(sort: sortOrder)
    }
    
    func createJSONDocument() -> JSONDocument {
        do {
            let jsonData = try JSONEncoder().encode(games)
            return JSONDocument(data: jsonData)
        } catch {
            fatalError("unable to create JSON document: \(error)")
        }
    }
    
    func performLogin() {
        let scopeRequest = ScopeRequest(scopeType: .user, scopes: ["account_info.read", "files.metadata.write", "files.metadata.read", "files.content.write", "files.content.read"], includeGrantedScopes: false)
        DropboxClientsManager.authorizeFromControllerV2(
            UIApplication.shared,
            controller: nil,
            loadingStatusDelegate: nil,
            openURL: { (url: URL) -> Void in UIApplication.shared.open(url, options: [:], completionHandler: nil) },
            scopeRequest: scopeRequest
        )
    }
    
    func uploadLibraryToDropbox() {
        guard let client = DropboxClientsManager.authorizedClient else {
            logger.warning("Dropbox not authorized")
            return
        }
        
        let fileData = createJSONDocument().data
        
        _ = client.files.upload(path: "/library.json", mode: .overwrite, input: fileData)
            .response { response, error in
                if let response = response {
                    logger.info("\(response)")
                } else if let error = error {
                    logger.error("\(error.localizedDescription)")
                }
            }
            .progress { progressData in
                print(progressData)
            }
    }
}

#Preview {
    GamesView(sortOrder: [SortDescriptor(\Game.name)])
        .modelContainer(for: Game.self)
}
