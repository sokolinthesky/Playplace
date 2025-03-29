import SwiftData
import SwiftUI
import os

struct AddGameView: View {
    let log = Logger()
    
    @Environment(\.dismiss) var dismiss
    
    var modelContext: ModelContext
    var gamesViewModel: GamesViewModel
    
    @State private var name = ""
    @State private var hoursInput: String = ""
    @State private var minutesInput: String = ""
    @State private var allPlatforms: [Platform] = []
    @State private var selectedPlatforms: Set<Platform> = []
    @State private var showPlatformSelection = false
    
    var totalSeconds: Int {
        let hours = Int(hoursInput) ?? 0
        let minutes = Int(minutesInput) ?? 0
        return (hours * 3600) + (minutes * 60)
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name:", text: $name)
                
                Section("Playtime") {
                    HStack {
                        Text("Hours:")
                        TextField("0", text: $hoursInput)
                            .keyboardType(.numberPad)
                            .frame(width: 80)
                        Text("Minutes:")
                        TextField("0", text: $minutesInput)
                            .keyboardType(.numberPad)
                            .frame(width: 80)
                    }
                    Text("Total seconds \(totalSeconds)")
                        .foregroundStyle(.gray)
                    
                }
                
                Section("Platforms") {
                    if !selectedPlatforms.isEmpty {
                        PlatformsView(selectedPlatforms: selectedPlatforms)
                    }
                    
                    Button(action: {
                        showPlatformSelection.toggle()
                    }) {
                        Text("Select Game Platforms")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                    }
                    .cornerRadius(6)
                }
                
                
                Button("Add Game") {
                    gamesViewModel.addGame(name: name, totalSeconds: totalSeconds, selectedPlatforms: selectedPlatforms)
                    dismiss()
                }
                .foregroundColor(.white)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .cornerRadius(6)
            }
            .onAppear {
                fetchPlatforms()
            }
            .sheet(isPresented: $showPlatformSelection) {
                PlatformSelectionView(selectedPlatforms: $selectedPlatforms, allPlatforms: allPlatforms)
            }
            .navigationTitle("Add Game")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
    func fetchPlatforms() {
        do {
            allPlatforms = try modelContext.fetch(FetchDescriptor<Platform>(sortBy: [SortDescriptor(\Platform.name)]))
        } catch {
            log.warning("Platforms fetch failed \(error)")
        }
    }
}

struct PlatformSelectionView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedPlatforms: Set<Platform>
    let allPlatforms: [Platform]
    
    var body: some View {
        NavigationView {
            List(allPlatforms, id: \.id) { platform in
                Button(action: {
                    if selectedPlatforms.contains(platform) {
                        selectedPlatforms.remove(platform)
                    } else {
                        selectedPlatforms.insert(platform)
                    }
                }) {
                    HStack {
                        Text("\(platform.name ?? "no name")")
                        Spacer()
                        if selectedPlatforms.contains(platform) {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
            .navigationTitle("Select Platforms")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Done") {
                dismiss()
            })
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Game.self, configurations: config)
        
        return AddGameView(modelContext: container.mainContext, gamesViewModel: GamesViewModel(modelContext: container.mainContext))
            .preferredColorScheme(.dark)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
