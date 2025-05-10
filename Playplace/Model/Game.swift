import Foundation
import SwiftData

@Model
class Game: Hashable, Codable {
    
    var backgroundImage: String?
    var desc: String?
    var notes: String?
    var genreIds: [String]?
    var enableSystemHdr: Bool?
    var hidden: Bool?
    var favorite: Bool?
    var icon: String?
    var coverImage: String?
    var installDirectory: String?
    var lastActivity: String?
    var sortingName: String?
    var gameId: String?
    var pluginId: String?
    var includeLibraryPluginAction: Bool?
    var gameActions: [GameAction]?
    var platformIds: [String]?
    var publisherIds: [String]?
    var developerIds: [String]?
    var releaseDate: ReleaseDate?
    var categoryIds: [String]?
    var tagIds: [String]?
    var featureIds: [String]?
    var links: [Link]?
    var roms: [GameRom]?
    var isInstalling: Bool?
    var isUninstalling: Bool?
    var isLaunching: Bool?
    var isRunning: Bool?
    var isInstalled: Bool?
    var overrideInstallState: Bool?
    var playtime: Int?
    var added: String?
    var modified: String?
    var playCount: Int?
    var installSize: Int?
    var lastSizeScanDate: String?
    var seriesIds: [String]?
    var version: String?
    var ageRatingIds: [String]?
    var regionIds: [String]?
    var sourceId: String?
    var completionStatusId: String?
    var userScore: Int?
    var criticScore: Int?
    var communityScore: Int?
    var preScript: String?
    var postScript: String?
    var gameStartedScript: String?
    var useGlobalPostScript: Bool?
    var useGlobalPreScript: Bool?
    var useGlobalGameStartedScript: Bool?
    var manual: String?
    var genres: [IdName]?
    var developers: [IdName]?
    var publishers: [IdName]?
    var tags: [IdName]?
    var features: [IdName]?
    var categories: [IdName]?
    var platforms: [Platform]?
    var series: [IdName]?
    var ageRatings: [IdName]?
    var regions: [Regions]?
    var source: IdName?
    var completionStatus: IdName?
    var releaseYear: Int?
    var recentActivity: String?
    var userScoreRating: Int?
    var communityScoreRating: Int?
    var criticScoreRating: Int?
    var userScoreGroup: Int?
    var communityScoreGroup: Int?
    var criticScoreGroup: Int?
    var lastActivitySegment: Int?
    var recentActivitySegment: Int?
    var addedSegment: Int?
    var modifiedSegment: Int?
    var playtimeCategory: Int?
    var installSizeGroup: Int?
    var isCustomGame: Bool?
    var installationStatus: Int?
    var id: String
    var name: String?
    
    init(imageCover: String) {
        self.backgroundImage = ""
        self.desc = ""
        self.notes = nil
        self.genreIds = []
        self.enableSystemHdr = false
        self.hidden = false
        self.favorite = false
        self.icon = nil
        self.coverImage = imageCover
        self.installDirectory = nil
        self.lastActivity = ""
        self.sortingName = nil
        self.gameId = ""
        self.pluginId = ""
        self.includeLibraryPluginAction = false
        self.gameActions = []
        self.platformIds = []
        self.publisherIds = []
        self.developerIds = []
        self.releaseDate = ReleaseDate()
        self.categoryIds = nil
        self.tagIds = nil
        self.featureIds = []
        self.links = []
        self.roms = []
        self.isInstalling = false
        self.isUninstalling = false
        self.isLaunching = false
        self.isRunning = false
        self.isInstalled = false
        self.overrideInstallState = false
        self.playtime = 0
        self.added = ""
        self.modified = ""
        self.playCount = 0
        self.installSize = nil
        self.lastSizeScanDate = nil
        self.seriesIds = []
        self.version = nil
        self.ageRatingIds = []
        self.regionIds = nil
        self.sourceId = ""
        self.completionStatusId = ""
        self.userScore = 0
        self.criticScore = 0
        self.communityScore = 0
        self.preScript = nil
        self.postScript = nil
        self.gameStartedScript = nil
        self.useGlobalPostScript = false
        self.useGlobalPreScript = false
        self.useGlobalGameStartedScript = false
        self.manual = nil
        self.genres = []
        self.developers = []
        self.publishers = []
        self.tags = nil
        self.features = []
        self.categories = nil
        self.platforms = []
        self.series = []
        self.ageRatings = []
        self.regions = []
        self.source = IdName()
        self.completionStatus = IdName()
        self.releaseYear = 0
        self.recentActivity = ""
        self.userScoreRating = 0
        self.communityScoreRating = 0
        self.criticScoreRating = 0
        self.userScoreGroup = 0
        self.communityScoreGroup = 0
        self.criticScoreGroup = 0
        self.lastActivitySegment = 0
        self.recentActivitySegment = 0
        self.addedSegment = 0
        self.modifiedSegment = 0
        self.playtimeCategory = 0
        self.installSizeGroup = 0
        self.isCustomGame = false
        self.installationStatus = 0
        self.id = UUID().uuidString
        self.name = ""
    }
    
    private enum CodingKeys: String, CodingKey {
        case backgroundImage = "BackgroundImage"
        case desc = "Description"
        case notes = "Notes"
        case genreIds = "GenreIds"
        case enableSystemHdr = "EnableSystemHdr"
        case hidden = "Hidden"
        case favorite = "Favorite"
        case icon = "Icon"
        case coverImage = "CoverImage"
        case installDirectory = "InstallDirectory"
        case lastActivity = "LastActivity"
        case sortingName = "SortingName"
        case gameId = "GameId"
        case pluginId = "PluginId"
        case includeLibraryPluginAction = "IncludeLibraryPluginAction"
        case gameActions = "GameActions"
        case platformIds = "PlatformIds"
        case publisherIds = "PublisherIds"
        case developerIds = "DeveloperIds"
        case releaseDate = "ReleaseDate"
        case categoryIds = "CategoryIds"
        case tagIds = "TagIds"
        case featureIds = "FeatureIds"
        case links = "Links"
        case roms = "Roms"
        case isInstalling = "IsInstalling"
        case isUninstalling = "IsUninstalling"
        case isLaunching = "IsLaunching"
        case isRunning = "IsRunning"
        case isInstalled = "IsInstalled"
        case overrideInstallState = "OverrideInstallState"
        case playtime = "Playtime"
        case added = "Added"
        case modified = "Modified"
        case playCount = "PlayCount"
        case installSize = "InstallSize"
        case lastSizeScanDate = "LastSizeScanDate"
        case seriesIds = "SeriesIds"
        case version = "Version"
        case ageRatingIds = "AgeRatingIds"
        case regionIds = "RegionIds"
        case sourceId = "SourceId"
        case completionStatusId = "CompletionStatusId"
        case userScore = "UserScore"
        case criticScore = "CriticScore"
        case communityScore = "CommunityScore"
        case preScript = "PreScript"
        case postScript = "PostScript"
        case gameStartedScript = "GameStartedScript"
        case useGlobalPostScript = "UseGlobalPostScript"
        case useGlobalPreScript = "UseGlobalPreScript"
        case useGlobalGameStartedScript = "UseGlobalGameStartedScript"
        case manual = "Manual"
        case genres = "Genres"
        case developers = "Developers"
        case publishers = "Publishers"
        case tags = "Tags"
        case features = "Features"
        case categories = "Categories"
        case platforms = "Platforms"
        case series = "Series"
        case ageRatings = "AgeRatings"
        case regions = "Regions"
        case source = "Source"
        case completionStatus = "CompletionStatus"
        case releaseYear = "ReleaseYear"
        case recentActivity = "RecentActivity"
        case userScoreRating = "UserScoreRating"
        case communityScoreRating = "CommunityScoreRating"
        case criticScoreRating = "CriticScoreRating"
        case userScoreGroup = "UserScoreGroup"
        case communityScoreGroup = "CommunityScoreGroup"
        case criticScoreGroup = "CriticScoreGroup"
        case lastActivitySegment = "LastActivitySegment"
        case recentActivitySegment = "RecentActivitySegment"
        case addedSegment = "AddedSegment"
        case modifiedSegment = "ModifiedSegment"
        case playtimeCategory = "PlaytimeCategory"
        case installSizeGroup = "InstallSizeGroup"
        case isCustomGame = "IsCustomGame"
        case installationStatus = "InstallationStatus"
        case id = "Id"
        case name = "Name"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        backgroundImage = try container.decodeIfPresent(String.self, forKey: .backgroundImage)
        desc = try container.decodeIfPresent(String.self, forKey: .desc)
        notes = try container.decodeIfPresent(String.self, forKey: .notes)
        genreIds = try container.decodeIfPresent([String].self, forKey: .genreIds)
        enableSystemHdr = try container.decodeIfPresent(Bool.self, forKey: .enableSystemHdr)
        hidden = try container.decodeIfPresent(Bool.self, forKey: .hidden)
        favorite = try container.decodeIfPresent(Bool.self, forKey: .favorite)
        icon = try container.decodeIfPresent(String.self, forKey: .icon)
        coverImage = try container.decodeIfPresent(String.self, forKey: .coverImage)
        installDirectory = try container.decodeIfPresent(String.self, forKey: .installDirectory)
        lastActivity = try container.decodeIfPresent(String.self, forKey: .lastActivity)
        sortingName = try container.decodeIfPresent(String.self, forKey: .sortingName)
        gameId = try container.decodeIfPresent(String.self, forKey: .gameId)
        pluginId = try container.decodeIfPresent(String.self, forKey: .pluginId)
        includeLibraryPluginAction = try container.decodeIfPresent(Bool.self, forKey: .includeLibraryPluginAction)
        gameActions = try container.decodeIfPresent([GameAction].self, forKey: .gameActions)
        platformIds = try container.decodeIfPresent([String].self, forKey: .platformIds)
        publisherIds = try container.decodeIfPresent([String].self, forKey: .publisherIds)
        developerIds = try container.decodeIfPresent([String].self, forKey: .developerIds)
        releaseDate = try container.decodeIfPresent(ReleaseDate.self, forKey: .releaseDate)
        categoryIds = try container.decodeIfPresent([String].self, forKey: .categoryIds)
        tagIds = try container.decodeIfPresent([String].self, forKey: .tagIds)
        featureIds = try container.decodeIfPresent([String].self, forKey: .featureIds)
        links = try container.decodeIfPresent([Link].self, forKey: .links)
        roms = try container.decodeIfPresent([GameRom].self, forKey: .roms)
        isInstalling = try container.decodeIfPresent(Bool.self, forKey: .isInstalling)
        isUninstalling = try container.decodeIfPresent(Bool.self, forKey: .isUninstalling)
        isLaunching = try container.decodeIfPresent(Bool.self, forKey: .isLaunching)
        isRunning = try container.decodeIfPresent(Bool.self, forKey: .isRunning)
        isInstalled = try container.decodeIfPresent(Bool.self, forKey: .isInstalled)
        overrideInstallState = try container.decode(Bool.self, forKey: .overrideInstallState)
        playtime = try container.decodeIfPresent(Int.self, forKey: .playtime)
        added = try container.decodeIfPresent(String.self, forKey: .added)
        modified = try container.decodeIfPresent(String.self, forKey: .modified)
        playCount = try container.decodeIfPresent(Int.self, forKey: .playCount)
        installSize = try container.decodeIfPresent(Int.self, forKey: .installSize)
        lastSizeScanDate = try container.decodeIfPresent(String.self, forKey: .lastSizeScanDate)
        seriesIds = try container.decodeIfPresent([String].self, forKey: .seriesIds)
        version = try container.decodeIfPresent(String.self, forKey: .version)
        ageRatingIds = try container.decodeIfPresent([String].self, forKey: .ageRatingIds)
        regionIds = try container.decodeIfPresent([String].self, forKey: .regionIds)
        sourceId = try container.decodeIfPresent(String.self, forKey: .sourceId)
        completionStatusId = try container.decodeIfPresent(String.self, forKey: .completionStatusId)
        userScore = try container.decodeIfPresent(Int.self, forKey: .userScore)
        criticScore = try container.decodeIfPresent(Int.self, forKey: .criticScore)
        communityScore = try container.decodeIfPresent(Int.self, forKey: .communityScore)
        preScript = try container.decodeIfPresent(String.self, forKey: .preScript)
        postScript = try container.decodeIfPresent(String.self, forKey: .postScript)
        gameStartedScript = try container.decodeIfPresent(String.self, forKey: .gameStartedScript)
        useGlobalPostScript = try container.decodeIfPresent(Bool.self, forKey: .useGlobalPostScript)
        useGlobalPreScript = try container.decodeIfPresent(Bool.self, forKey: .useGlobalPreScript)
        useGlobalGameStartedScript = try container.decode(Bool.self, forKey: .useGlobalGameStartedScript)
        manual = try container.decodeIfPresent(String.self, forKey: .manual)
        genres = try container.decodeIfPresent([IdName].self, forKey: .genres)
        developers = try container.decodeIfPresent([IdName].self, forKey: .developers)
        publishers = try container.decodeIfPresent([IdName].self, forKey: .publishers)
        tags = try container.decodeIfPresent([IdName].self, forKey: .tags)
        features = try container.decodeIfPresent([IdName].self, forKey: .features)
        categories = try container.decodeIfPresent([IdName].self, forKey: .categories)
        platforms = try container.decodeIfPresent([Platform].self, forKey: .platforms)
        series = try container.decodeIfPresent([IdName].self, forKey: .series)
        ageRatings = try container.decodeIfPresent([IdName].self, forKey: .ageRatings)
        regions = try container.decodeIfPresent([Regions].self, forKey: .regions)
        source = try container.decodeIfPresent(IdName.self, forKey: .source)
        completionStatus = try container.decodeIfPresent(IdName.self, forKey: .completionStatus)
        releaseYear = try container.decodeIfPresent(Int.self, forKey: .releaseYear)
        recentActivity = try container.decodeIfPresent(String.self, forKey: .recentActivity)
        userScoreRating = try container.decodeIfPresent(Int.self, forKey: .userScoreRating)
        communityScoreRating = try container.decodeIfPresent(Int.self, forKey: .communityScoreRating)
        criticScoreRating = try container.decodeIfPresent(Int.self, forKey: .criticScoreRating)
        userScoreGroup = try container.decodeIfPresent(Int.self, forKey: .userScoreGroup)
        communityScoreGroup = try container.decodeIfPresent(Int.self, forKey: .communityScoreGroup)
        criticScoreGroup = try container.decodeIfPresent(Int.self, forKey: .criticScoreGroup)
        lastActivitySegment = try container.decodeIfPresent(Int.self, forKey: .lastActivitySegment)
        recentActivitySegment = try container.decodeIfPresent(Int.self, forKey: .recentActivitySegment)
        addedSegment = try container.decodeIfPresent(Int.self, forKey: .addedSegment)
        modifiedSegment = try container.decodeIfPresent(Int.self, forKey: .modifiedSegment)
        playtimeCategory = try container.decodeIfPresent(Int.self, forKey: .playtimeCategory)
        installSizeGroup = try container.decodeIfPresent(Int.self, forKey: .installSizeGroup)
        isCustomGame = try container.decodeIfPresent(Bool.self, forKey: .isCustomGame)
        installationStatus = try container.decodeIfPresent(Int.self, forKey: .installationStatus)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(backgroundImage, forKey: .backgroundImage)
        try container.encode(desc, forKey: .desc)
        try container.encode(notes, forKey: .notes)
        try container.encode(genreIds, forKey: .genreIds)
        try container.encode(enableSystemHdr, forKey: .enableSystemHdr)
        try container.encode(hidden, forKey: .hidden)
        try container.encode(favorite, forKey: .favorite)
        try container.encode(icon, forKey: .icon)
        try container.encode(coverImage, forKey: .coverImage)
        try container.encode(installDirectory, forKey: .installDirectory)
        try container.encode(lastActivity, forKey: .lastActivity)
        try container.encode(sortingName, forKey: .sortingName)
        try container.encode(gameId?.isEmpty == true ? nil : gameId, forKey: .gameId)
        try container.encode(pluginId?.isEmpty == true ? nil : pluginId, forKey: .pluginId)
        try container.encode(includeLibraryPluginAction, forKey: .includeLibraryPluginAction)
        try container.encode(gameActions, forKey: .gameActions)
        try container.encode(platformIds, forKey: .platformIds)
        try container.encode(publisherIds, forKey: .publisherIds)
        try container.encode(developerIds, forKey: .developerIds)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(categoryIds, forKey: .categoryIds)
        try container.encode(tagIds, forKey: .tagIds)
        try container.encode(featureIds, forKey: .featureIds)
        try container.encode(links, forKey: .links)
        try container.encode(roms, forKey: .roms)
        try container.encode(isInstalling, forKey: .isInstalling)
        try container.encode(isUninstalling, forKey: .isUninstalling)
        try container.encode(isLaunching, forKey: .isLaunching)
        try container.encode(isRunning, forKey: .isRunning)
        try container.encode(isInstalled, forKey: .isInstalled)
        try container.encode(overrideInstallState, forKey: .overrideInstallState)
        try container.encode(playtime, forKey: .playtime)
        try container.encode(added, forKey: .added)
        try container.encode(modified, forKey: .modified)
        try container.encode(playCount, forKey: .playCount)
        try container.encode(installSize, forKey: .installSize)
        try container.encode(lastSizeScanDate?.isEmpty == true ? nil : lastSizeScanDate, forKey: .lastSizeScanDate)
        try container.encode(seriesIds, forKey: .seriesIds)
        try container.encode(version, forKey: .version)
        try container.encode(ageRatingIds, forKey: .ageRatingIds)
        try container.encode(regionIds, forKey: .regionIds)
        try container.encode(sourceId?.isEmpty == true ? nil : sourceId, forKey: .sourceId)
        try container.encode(completionStatusId?.isEmpty == true ? nil : completionStatusId, forKey: .completionStatusId)
        try container.encode(userScore, forKey: .userScore)
        try container.encode(criticScore, forKey: .criticScore)
        try container.encode(communityScore, forKey: .communityScore)
        try container.encode(preScript, forKey: .preScript)
        try container.encode(postScript, forKey: .postScript)
        try container.encode(gameStartedScript, forKey: .gameStartedScript)
        try container.encode(useGlobalPostScript, forKey: .useGlobalPostScript)
        try container.encode(useGlobalPreScript, forKey: .useGlobalPreScript)
        try container.encode(useGlobalGameStartedScript, forKey: .useGlobalGameStartedScript)
        try container.encode(manual, forKey: .manual)
        try container.encode(genres, forKey: .genres)
        try container.encode(developers, forKey: .developers)
        try container.encode(publishers, forKey: .publishers)
        try container.encode(tags, forKey: .tags)
        try container.encode(features, forKey: .features)
        try container.encode(categories, forKey: .categories)
        try container.encode(platforms, forKey: .platforms)
        try container.encode(series, forKey: .series)
        try container.encode(ageRatings, forKey: .ageRatings)
        try container.encode(regions, forKey: .regions)
        try container.encode(source, forKey: .source)
        try container.encode(completionStatus, forKey: .completionStatus)
        try container.encode(releaseYear, forKey: .releaseYear)
        try container.encode(recentActivity, forKey: .recentActivity)
        try container.encode(userScoreRating, forKey: .userScoreRating)
        try container.encode(communityScoreRating, forKey: .communityScoreRating)
        try container.encode(criticScoreRating, forKey: .criticScoreRating)
        try container.encode(userScoreGroup, forKey: .userScoreGroup)
        try container.encode(communityScoreGroup, forKey: .communityScoreGroup)
        try container.encode(criticScoreGroup, forKey: .criticScoreGroup)
        try container.encode(lastActivitySegment, forKey: .lastActivitySegment)
        try container.encode(recentActivitySegment, forKey: .recentActivitySegment)
        try container.encode(addedSegment, forKey: .addedSegment)
        try container.encode(modifiedSegment, forKey: .modifiedSegment)
        try container.encode(playtimeCategory, forKey: .playtimeCategory)
        try container.encode(installSizeGroup, forKey: .installSizeGroup)
        try container.encode(isCustomGame, forKey: .isCustomGame)
        try container.encode(installationStatus, forKey: .installationStatus)
        try container.encode(id.isEmpty ? nil : id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
    
    @Model
    class ReleaseDate: Codable {
        var releaseDate: String?
        
        init() {
            self.releaseDate = nil
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(releaseDate?.isEmpty == true ? nil : releaseDate, forKey: .releaseDate)
        }
        
        private enum CodingKeys: String, CodingKey {
            case releaseDate = "ReleaseDate"
        }
    }
    
    class Link: Codable {
        var name: String?
        var url: String?
        
        init() {
            self.name = ""
            self.url = ""
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            name = try container.decodeIfPresent(String.self, forKey: .name)
            url = try container.decodeIfPresent(String.self, forKey: .url)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(name, forKey: .name)
            try container.encode(url, forKey: .url)
        }
        
        private enum CodingKeys: String, CodingKey {
            case name = "Name"
            case url = "Url"
        }
    }
    
    @Model
    class Regions: Codable {
        var id: String?
        var name: String?
        var specificationId: String?
        
        init() {
            self.id = nil
            self.name = ""
            self.specificationId = ""
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decodeIfPresent(String.self, forKey: .id)
            name = try container.decodeIfPresent(String.self, forKey: .name)
            specificationId = try container.decodeIfPresent(String.self, forKey: .specificationId)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id?.isEmpty == true ? nil : id, forKey: .id)
            try container.encode(name, forKey: .name)
            try container.encode(specificationId, forKey: .specificationId)
        }
        
        private enum CodingKeys: String, CodingKey {
            case id = "Id"
            case name = "Name"
            case specificationId = "SpecificationId"
        }
    }
    
    @Model
    class GameRom: Codable {
        var name: String?
        var path: String?
        
        init() {
            self.name = ""
            self.path = ""
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            name = try container.decodeIfPresent(String.self, forKey: .name)
            path = try container.decodeIfPresent(String.self, forKey: .path)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(name, forKey: .name)
            try container.encode(path, forKey: .path)
        }
        
        private enum CodingKeys: String, CodingKey {
            case name = "Name"
            case path = "Path"
        }
    }
    
    @Model
    class GameAction: Codable {
        var type: Int?
        var arguments: String?
        var additionalArguments: String?
        var overrideDefaultArgs: Bool?
        var path: String?
        var workingDir: String?
        var name: String?
        var isPlayAction: Bool?
        var emulatorId: String?
        var emulatorProfileId: String?
        var trackingMode: Int?
        var trackingPath: String?
        var script: String?
        var initialTrackingDelay: Int?
        var trackingFrequency: Int?
        
        init () {
            self.arguments = ""
            self.additionalArguments = ""
            self.overrideDefaultArgs = false
            self.path = ""
            self.workingDir = ""
            self.name = ""
            self.isPlayAction = false
            self.emulatorId = ""
        }
        
        enum CodingKeys: String, CodingKey {
            case type = "Type"
            case arguments = "Arguments"
            case additionalArguments = "AdditionalArguments"
            case overrideDefaultArgs = "OverrideDefaultArgs"
            case path = "Path"
            case workingDir = "WorkingDir"
            case name = "Name"
            case isPlayAction = "IsPlayAction"
            case emulatorId = "EmulatorId"
            case emulatorProfileId = "EmulatorProfileId"
            case trackingMode = "TrackingMode"
            case trackingPath = "TrackingPath"
            case script = "Script"
            case initialTrackingDelay = "InitialTrackingDelay"
            case trackingFrequency = "TrackingFrequency"
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            type = try container.decodeIfPresent(Int.self, forKey: .type)
            arguments = try container.decodeIfPresent(String.self, forKey: .arguments)
            additionalArguments = try container.decodeIfPresent(String.self, forKey: .additionalArguments)
            overrideDefaultArgs = try container.decodeIfPresent(Bool.self, forKey: .overrideDefaultArgs)
            path = try container.decodeIfPresent(String.self, forKey: .path)
            workingDir = try container.decodeIfPresent(String.self, forKey: .workingDir)
            name = try container.decodeIfPresent(String.self, forKey: .name)
            isPlayAction = try container.decodeIfPresent(Bool.self, forKey: .isPlayAction)
            emulatorId = try container.decodeIfPresent(String.self, forKey: .emulatorId)
            emulatorProfileId = try container.decodeIfPresent(String.self, forKey: .emulatorProfileId)
            trackingMode = try container.decodeIfPresent(Int.self, forKey: .trackingMode)
            trackingPath = try container.decodeIfPresent(String.self, forKey: .trackingPath)
            script = try container.decodeIfPresent(String.self, forKey: .script)
            initialTrackingDelay = try container.decodeIfPresent(Int.self, forKey: .initialTrackingDelay)
            trackingFrequency = try container.decodeIfPresent(Int.self, forKey: .trackingFrequency)
        }
        
        func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(type, forKey: .type)
            try container.encode(arguments?.isEmpty == true ? nil : arguments, forKey: .arguments)
            try container.encode(additionalArguments, forKey: .additionalArguments)
            try container.encode(overrideDefaultArgs, forKey: .overrideDefaultArgs)
            try container.encode(path?.isEmpty == true ? nil : path, forKey: .path)
            try container.encode(workingDir?.isEmpty == true ? nil : workingDir, forKey: .workingDir)
            try container.encode(name?.isEmpty == true ? nil : name, forKey: .name)
            try container.encode(isPlayAction?.description ?? "false", forKey: .isPlayAction)
            try container.encode(emulatorId?.isEmpty == true ? nil : emulatorId, forKey: .emulatorId)
            try container.encode(emulatorProfileId?.isEmpty == true ? nil : emulatorProfileId, forKey: .emulatorProfileId)
            try container.encode(trackingMode, forKey: .trackingMode)
            try container.encode(trackingPath?.isEmpty == true ? nil : trackingPath, forKey: .trackingPath)
            try container.encode(trackingFrequency, forKey: .trackingFrequency)
            try container.encode(initialTrackingDelay, forKey: .initialTrackingDelay)
            try container.encode(script, forKey: .script)
        }
    }
    
    @Model
    class IdName: Codable {
        var id: String?
        var name: String?
        
        init() {
            self.id = nil
            self.name = ""
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
}

