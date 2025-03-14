import SwiftData
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    GamesView(sortOrder: [SortDescriptor(\Game.name)])
                }
                .navigationDestination(for: Game.self) { game in
                    GameDetailView(game: game)
                }
                
                VStack {
                    Spacer()
                    HStack {
                        LibraryManagmentButtonView()
                        
                        Spacer()
                        
                        Button(action: {
                            //todo: impl search
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
