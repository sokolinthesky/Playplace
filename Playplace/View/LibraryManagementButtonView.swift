import SwiftData
import UniformTypeIdentifiers
import SwiftUI
import SwiftyDropbox
import os

struct LibraryManagmentButtonView: View {
    let logger = Logger()
    let importService = ImportService()
    
    @Environment(\.modelContext) var modelContext
    
    @State private var importing = false;
    @State private var importingLibrary = false
    @State private var importingImages = false
    @State private var exportingLibrary = false
    @State private var showAddGameView = false
    
    var body: some View {
        VStack {
            Menu {
                Button("Import Library") {
                    importing.toggle()
                    importingLibrary.toggle()
                }
                Button("Import Images") {
                    importing.toggle()
                    importingImages.toggle()
                }
                Button("Export Library") {
                    exportingLibrary.toggle()
                }
                
                Button("Dropbox Auth") {
                    performLogin()
                }
                .onOpenURL { url in
                    let oauthCompletion: DropboxOAuthCompletion = {
                        if let authResult = $0 {
                            switch authResult {
                            case .success:
                                logger.info("Sucess dropbox authentivcation")
                            case .cancel:
                                logger.warning("Authorization flow was manually canceled by user")
                            case .error(_, let description):
                                logger.error("Error: \(String(describing: description))")
                            }
                        }
                    }
                    DropboxClientsManager.handleRedirectURL(url, backgroundSessionIdentifier: "pp-dpb-session", completion: oauthCompletion)
                }
                
                Button("Dropbox Upload") {
                    uploadLibraryToDropbox()
                }
                
                Button("Add Game") { showAddGameView.toggle() }
            } label: {
                Image(systemName: "folder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            }
            .padding(.leading)
        }
        .fileImporter(
            isPresented: $importing,
            allowedContentTypes: importingImages ? [.folder, .image] : [.json],
            allowsMultipleSelection: importingImages ? true : false
        ) { result in
            switch result {
            case .success(let urls):
                if importingLibrary {
                    importService.importLibrary(url: urls.first!, modelContext: modelContext)
                    importingLibrary.toggle()
                } else if importingImages {
                    importService.importImages(urls: urls)
                    importingImages.toggle()
                }
            case .failure(let error):
                fatalError("Import error: \(error.localizedDescription)")
            }
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
        .sheet(isPresented: $showAddGameView) {
            AddGameView()
        }
    }
    
    func createJSONDocument() -> JSONDocument {
        do {
            let games = try modelContext.fetch(FetchDescriptor<Game>())
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
    LibraryManagmentButtonView()
}
