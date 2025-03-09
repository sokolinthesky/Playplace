import SwiftData
import SwiftUI

struct AddGameView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \Platform.name) var allPlatforms: [Platform]
    
    @State private var name = ""
    @State private var hoursInput: String = ""
    @State private var minutesInput: String = ""
    
    var totalSeconds: Int {
        let hours = Int(hoursInput) ?? 0
        let minutes = Int(minutesInput) ?? 0
        return (hours * 3600) + (minutes * 60)
    }
    
    @State private var selectedPlatforms: Set<Platform> = []
    @State private var showPlatformSelection = false
    
    var body: some View {
        NavigationView {
            Form {
                
                TextField("Name:", text: $name)
                
                Section("Playtime") {
                    HStack {
                        TextField("Hours", text: $hoursInput)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 80)
                        Text("hour(s)")
                        TextField("Minutes", text: $minutesInput)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 80)
                        Text("minutes(s)")
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
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.blue)
                    }
                    .cornerRadius(6)
                }
                
                Button("Add game") {
                    addGame()
                    dismiss()
                }
            }
            .sheet(isPresented: $showPlatformSelection) {
                PlatformSelectionView(selectedPlatforms: $selectedPlatforms, allPlatforms: allPlatforms)
            }
            .navigationTitle("Add Game")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
    func addGame() {
        let game = Game(imageCover: "")
        game.name = name
        game.platforms = Array(selectedPlatforms)
        game.playtime = totalSeconds
        modelContext.insert(game)
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

struct PlatformsView: View {
    let selectedPlatforms: Set<Platform>
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Array(selectedPlatforms), id: \.id) { platform in
                    Text("\(platform.name ?? "no name")")
                        .padding(5)
                        .background(
                            Capsule()
                                .fill(Color.blue)
                        )
                        .foregroundColor(.white)
                }
            }
        }
    }
}


#Preview {
    AddGameView()
}
