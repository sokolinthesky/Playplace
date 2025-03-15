import SwiftData
import SwiftUI

struct ContentView: View {
    
    @State private var searchText = ""
    @State private var isSearchActive = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    GamesView(searchText: searchText, sortOrder: [SortDescriptor(\Game.name)])
                        .searchable(text: $searchText, isPresented: $isSearchActive, placement: .automatic)
                }
                .navigationDestination(for: Game.self) { game in
                    GameDetailView(game: game)
                }
                .navigationTitle("Library")
                .navigationBarTitleDisplayMode(.inline)
                
                VStack {
                    Spacer()
                    HStack {
                        LibraryManagmentButtonView()
                        
                        Spacer()
                        
                        Button(action: {
                            searchText = ""
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
    }
}

#Preview {
    ContentView()
}
