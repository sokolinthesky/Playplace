import Foundation
import SwiftData
import Combine
import os

final class GamesViewModel: ObservableObject {
    let log = Logger()
    private var cancellables = Set<AnyCancellable>()
    
    private var defaultSort: SortDescriptor<Game> = SortDescriptor(\Game.name)
    
    @Published var searchText: String = ""
    @Published private(set) var games: [Game] = []
    @Published private(set) var filteredGames: [Game] = []
    
    var modelContext: ModelContext
    
    init (modelContext: ModelContext) {
        self.modelContext = modelContext
        addSubscribers()
    }
    
    private func addSubscribers() {
        $searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] searchText in
                self?.filterGames(searchText: searchText)
            })
            .store(in: &cancellables)
    }
    
    func fetchGames() async {
        do {
            try await MainActor.run(body: {
                games = try modelContext.fetch(FetchDescriptor<Game>(sortBy: [defaultSort]))
            })
        } catch {
            log.warning("Fetch failed \(error)")
        }
    }
    
    func filterGames(searchText: String) {
        do {
            if searchText.isEmpty {
                filteredGames = games
                return
            }
            let descriptor = FetchDescriptor<Game>(
                predicate: #Predicate { $0.name?.localizedStandardContains(searchText) == true },
                sortBy: [defaultSort])
            filteredGames = try modelContext.fetch(descriptor)
        } catch {
            log.warning("Filter failed \(error)")
        }
    }
    
    func addGame(name: String, totalSeconds: Int, selectedPlatforms: Set<Platform>) {
        let game = Game(imageCover: "")
        game.name = name
        game.platforms = Array(selectedPlatforms)
        game.playtime = totalSeconds
        modelContext.insert(game)
        Task {
            await fetchGames()
        }
    }
}
