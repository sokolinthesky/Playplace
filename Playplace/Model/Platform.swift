import Foundation
import SwiftData

@Model
class Platform: Codable, IdentifiableString {
    var specificationId: String?
    var icon: String?
    var cover: String?
    var background: String?
    var id: String
    var name: String?
    
    var games: [Game]?
    
    init() {
        self.specificationId = ""
        self.icon = nil
        self.cover = nil
        self.background = nil
        self.id = ""
        self.name = ""
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        specificationId = try container.decodeIfPresent(String.self, forKey: .specificationId)
        icon = try container.decodeIfPresent(String.self, forKey: .icon)
        cover = try container.decodeIfPresent(String.self, forKey: .cover)
        background = try container.decodeIfPresent(String.self, forKey: .background)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(specificationId, forKey: .specificationId)
        try container.encode(icon, forKey: .icon)
        try container.encode(cover, forKey: .cover)
        try container.encode(background, forKey: .background)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
    
    private enum CodingKeys: String, CodingKey {
        case specificationId = "SpecificationId"
        case icon = "Icon"
        case cover = "Cover"
        case background = "Background"
        case id = "Id"
        case name = "Name"
    }
    
}
