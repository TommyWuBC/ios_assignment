import SwiftUI

struct PlantDetailView: View {
    @EnvironmentObject var viewModel: PlantViewModel
    @Environment(\.dismiss) var dismiss

    var plant: Plant

    @State private var editableName: String
    @State private var editableInterval: WateringInterval

    @State private var showDeleteConfirmation = false

    init(plant: Plant) {
        self.plant = plant
        _editableName = State(initialValue: plant.name)
        _editableInterval = State(initialValue: plant.interval)
    }

    /// The plant reflecting the currently edited name/interval.
    private var currentPlant: Plant {
        var updated = plant
        updated.name = editableName
        updated.interval = editableInterval
        return updated
    }

    var body: some View {
        Form {
            Section("Name") {
                TextField("Plant name", text: $editableName)
                    .onChange(of: editableName) { _, _ in
                        viewModel.updatePlant(currentPlant)
                    }
            }

            Section("Watering Interval") {
                Picker("Interval", selection: $editableInterval) {
                    ForEach(WateringInterval.allCases, id: \.self) { interval in
                        Text(interval.rawValue).tag(interval)
                    }
                }
                .onChange(of: editableInterval) { _, _ in
                    viewModel.updatePlant(currentPlant)
                }
            }

            Section("Status") {
                LabeledContent("Next Watering", value: currentPlant.nextWateringDate.shortFormatted)
                LabeledContent("Status", value: statusLabel)
                Button("Mark as Watered") {
                    viewModel.markWatered(currentPlant)
                    dismiss()
                }
                .foregroundColor(.green)
            }

            Section {
                Button(role: .destructive) {
                    showDeleteConfirmation = true
                } label: {
                    Text("Delete Plant")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .navigationTitle(currentPlant.name)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete \(currentPlant.name)?", isPresented: $showDeleteConfirmation) {
            Button("Delete", role: .destructive) {
                viewModel.deletePlant(id: plant.id)
                dismiss()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This action cannot be undone.")
        }
    }

    private var statusLabel: String {
        switch currentPlant.urgency {
        case .overdue:
            let days = currentPlant.daysOverdue
            return "\(days) day\(days == 1 ? "" : "s") overdue"
        case .dueToday:
            return "Due today"
        case .upcoming:
            return "Upcoming"
        }
    }
}

#Preview {
    NavigationStack {
        PlantDetailView(plant: Plant(
            name: "Cactus",
            emoji: "🌵",
            interval: .everyWeek,
            lastWatered: Date()
        ))
        .environmentObject(PlantViewModel())
    }
}
