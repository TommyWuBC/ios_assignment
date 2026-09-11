import SwiftUI

@main
struct PlantWateringAssignmentApp: App {
    @StateObject private var viewModel = PlantViewModel()

    var body: some Scene {
        WindowGroup {
            PlantListView()
                .environmentObject(viewModel)
        }
    }
}
