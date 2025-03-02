import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct JSONDocument: FileDocument {
    var data: Data
    
    static var readableContentTypes: [UTType] { [.json] }
    
    init(data: Data) {
        self.data = data
    }
    
    init(configuration: ReadConfiguration) throws {
        self.data = configuration.file.regularFileContents ?? Data()
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: data)
    }
}
