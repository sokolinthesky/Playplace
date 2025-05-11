import Foundation
import SwiftData

@Model
class IdName: Codable {
    var id: String?
    var name: String?
    
    var games: [Game]?
    
    init() {
        self.id = nil
        self.name = nil
    }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id?.isEmpty == true ? nil : id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
    }
}
