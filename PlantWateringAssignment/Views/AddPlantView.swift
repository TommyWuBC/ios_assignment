import SwiftUI

struct AddPlantView: View {
    @EnvironmentObject var viewModel: PlantViewModel
    @Environment(\.dismiss) var dismiss

    @State private var name: String = ""
    @State private var selectedEmoji: String = "🌵"
    @State private var selectedInterval: WateringInterval = .everyWeek

    let emojiOptions = ["🌵", "🌿", "🌸", "🌻", "🪴", "🍀", "🌱", "🌾"]

    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Plant name", text: $name)
                }

                Section("Emoji") {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 12) {
                        ForEach(emojiOptions, id: \.self) { emoji in
                            Button {
                                selectedEmoji = emoji
                            } label: {
                                Text(emoji)
                                    .font(.largeTitle)
                                    .frame(maxWidth: .infinity)
                                    .padding(8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(selectedEmoji == emoji ? Color.accentColor.opacity(0.25) : Color.clear)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(selectedEmoji == emoji ? Color.accentColor : Color.clear, lineWidth: 2)
                                    )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical, 4)
                }

                Section("Watering Interval") {
                    Picker("Interval", selection: $selectedInterval) {
                        ForEach(WateringInterval.allCases, id: \.self) { interval in
                            Text(interval.rawValue).tag(interval)
                        }
                    }
                }
            }
            .navigationTitle("Add Plant")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        viewModel.addPlant(name: name, emoji: selectedEmoji, interval: selectedInterval)
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddPlantView()
        .environmentObject(PlantViewModel())
}
