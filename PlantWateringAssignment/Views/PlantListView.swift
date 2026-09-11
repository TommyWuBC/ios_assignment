import SwiftUI

struct PlantListView: View {
    @EnvironmentObject var viewModel: PlantViewModel
    @State private var showingAddPlant = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.sortedPlants) { plant in
                    NavigationLink {
                        PlantDetailView(plant: plant)
                    } label: {
                        PlantCardView(plant: plant)
                    }
                    .listRowBackground(rowBackgroundColor(for: plant.urgency))
                }
            }
            .navigationTitle("My Plants")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddPlant = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddPlant) {
                AddPlantView()
            }
        }
    }

    private func rowBackgroundColor(for urgency: Urgency) -> Color {
        switch urgency {
        case .overdue: return Color.red.opacity(0.15)
        case .dueToday: return Color.yellow.opacity(0.2)
        case .upcoming: return Color(.systemBackground)
        }
    }
}

// MARK: - Plant Card

struct PlantCardView: View {
    let plant: Plant

    var body: some View {
        HStack {
            Text(plant.emoji)
                .font(.largeTitle)

            VStack(alignment: .leading, spacing: 2) {
                Text(plant.name)
                    .font(.headline)
                Text("\(plant.interval.rawValue) • Next: \(plant.nextWateringDate.shortFormatted)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                if plant.urgency == .overdue {
                    Text("\(plant.daysOverdue) day\(plant.daysOverdue == 1 ? "" : "s") overdue")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                } else if plant.urgency == .dueToday {
                    Text("Due today")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                }
            }

            Spacer()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    PlantListView()
        .environmentObject(PlantViewModel())
}
