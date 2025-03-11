import SwiftUI

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
    PlatformsView(selectedPlatforms: [Platform(id: UUID().uuidString, name: "PlayStation 5")])
}
