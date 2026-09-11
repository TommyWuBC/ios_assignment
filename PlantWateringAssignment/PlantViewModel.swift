import Foundation
import SwiftUI

@MainActor
class PlantViewModel: ObservableObject {
    @Published var plants: [Plant] = []

    // MARK: - Sorted List

    /// Returns plants sorted by urgency: most overdue first.
    var sortedPlants: [Plant] {
        plants.sorted { lhs, rhs in
            if lhs.urgency != rhs.urgency {
                return urgencyPriority(lhs.urgency) < urgencyPriority(rhs.urgency)
            }
            return lhs.daysOverdue > rhs.daysOverdue
        }
    }

    private func urgencyPriority(_ urgency: Urgency) -> Int {
        switch urgency {
        case .overdue: return 0
        case .dueToday: return 1
        case .upcoming: return 2
        }
    }

    // MARK: - CRUD

    /// Adds a new plant to the list.
    func addPlant(name: String, emoji: String, interval: WateringInterval) {
        let plant = Plant(name: name, emoji: emoji, interval: interval, lastWatered: Date())
        plants.append(plant)
    }

    /// Updates an existing plant by ID.
    func updatePlant(_ updated: Plant) {
        guard let index = plants.firstIndex(where: { $0.id == updated.id }) else { return }
        plants[index] = updated
    }

    /// Marks a plant as watered today, resetting its timer.
    func markWatered(_ plant: Plant) {
        var updated = plant
        updated.lastWatered = Date()
        updatePlant(updated)
    }

    /// Deletes a plant by ID.
    func deletePlant(id: UUID) {
        plants.removeAll { $0.id == id }
    }
}
