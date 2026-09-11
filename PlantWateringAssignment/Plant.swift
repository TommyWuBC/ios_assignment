import Foundation

/// Represents a single plant the user wants to track.
struct Plant: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var emoji: String
    var interval: WateringInterval
    var lastWatered: Date

    /// The next date this plant needs to be watered.
    var nextWateringDate: Date {
        Calendar.current.date(byAdding: .day, value: interval.days, to: lastWatered) ?? lastWatered
    }

    /// How many days overdue this plant is (negative means upcoming).
    var daysOverdue: Int {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let dueDay = calendar.startOfDay(for: nextWateringDate)
        return calendar.dateComponents([.day], from: dueDay, to: today).day ?? 0
    }

    /// The urgency category used to color the card.
    var urgency: Urgency {
        if daysOverdue > 0 {
            return .overdue
        } else if daysOverdue == 0 {
            return .dueToday
        } else {
            return .upcoming
        }
    }
}

// MARK: - Supporting Types

enum WateringInterval: String, CaseIterable, Codable {
    case everyDay      = "Every Day"
    case every3Days    = "Every 3 Days"
    case everyWeek     = "Every Week"
    case every2Weeks   = "Every 2 Weeks"
    case everyMonth    = "Every Month"

    /// Number of days between waterings.
    var days: Int {
        switch self {
        case .everyDay: return 1
        case .every3Days: return 3
        case .everyWeek: return 7
        case .every2Weeks: return 14
        case .everyMonth: return 30
        }
    }
}

enum Urgency {
    case overdue, dueToday, upcoming
}

// MARK: - Date Formatting

private let shortDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d"
    return formatter
}()

extension Date {
    /// Formats the date as a short, readable string (e.g., "Sep 12").
    var shortFormatted: String {
        shortDateFormatter.string(from: self)
    }
}
