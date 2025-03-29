import SwiftData
import SwiftUI

struct GamesView: View {
    let layout = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    var modelContext: ModelContext

    @State private var isSearchActive = false    
    @StateObject private var viewModel: GamesViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: layout) {
                    ForEach(viewModel.searchText.isEmpty ? viewModel.games : viewModel.filteredGames, id: \.id) { game in
                        NavigationLink(value: game) {
                            GameView(game: game)
                        }
                    }
                }
                .padding([.horizontal], 1)
                .searchable(text: $viewModel.searchText, isPresented: $isSearchActive, placement: .automatic)
                .task {
                    await viewModel.fetchGames()
                }
            }
            .refreshable {
                await viewModel.fetchGames()
            }
            
            VStack {
                Spacer()
                HStack {
                    LibraryManagmentButtonView(modelContext: modelContext, gamesViewModel: viewModel)
                    
                    Spacer()
                    
                        Button(action: {
                            isSearchActive.toggle()
                        }) {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding(.trailing)
                }
            }
        }
    }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        let gamesViewModel = GamesViewModel(modelContext: modelContext)
        _viewModel = StateObject(wrappedValue: gamesViewModel)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Game.self, configurations: config)
        
        return GamesView(modelContext: container.mainContext)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
