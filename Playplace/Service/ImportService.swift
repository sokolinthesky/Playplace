//
//  ImportSercice.swift
//  Playplace
//
//  Created by JC Denton on 28.02.2025.
//

import Foundation
import SwiftData

struct ImportSercice {
    
    func importLibrary(url: URL, modelContext: ModelContext) {
        do {
            let decodedGames: [Game] = Bundle.main.decode(url)
            try modelContext.delete(model: Game.self)
            for game in decodedGames {
                importPlatforms(game: game, modelContext: modelContext)
                modelContext.insert(game)
            }
            try modelContext.save()
        } catch {
            fatalError("Failed to import library: \(error)")
        }
    }
    
    func importPlatforms(game: Game, modelContext: ModelContext) {
        var platformsForGame: [Platform] = []
        if let platforms = game.platforms {
            for platform in platforms {
                let fetched = fetch(ids: [platform.id], modelContext: modelContext)
                platformsForGame.append(fetched.isEmpty ? platform : fetched[0])
            }
        }
        game.platforms = platformsForGame
    }
    
    func fetch(ids: [String], modelContext: ModelContext) -> [Platform] {
        var models: [Platform] = []
        do {
            let predicate = #Predicate<Platform> {
                ids.contains($0.id)
            }
            let descriptor = FetchDescriptor<Platform>(predicate: predicate, sortBy: [SortDescriptor(\.name)])
            models = try modelContext.fetch(descriptor)
            return models
        } catch {
            return []
        }
    }
}
