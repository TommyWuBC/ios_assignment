# Plant Watering Assignment

## Overview

In this mini-project, you'll build a **Plant Watering Tracker** — an app that helps users remember when to water their plants. You'll practice working with dates, dynamic list states, and inline editing in SwiftUI.

---

## Features to Implement

### Main List (`PlantListView`)

- Display a scrollable list of plant cards, each showing:
  - Plant **name** and **emoji**
  - Watering **interval** (e.g., Every 3 Days)
  - **Next due date** (formatted as a readable date string)
- Color-coded urgency states:
  - **Red** — overdue, with a label like *"2 days overdue"*
  - **Yellow** — due today
  - **Neutral (gray/default)** — upcoming
- Plants are **sorted by urgency** (most overdue first)

### Add Plant (`AddPlantView`)

- Input fields for:
  - Plant **name** (text field)
  - **Emoji picker** with 6–8 options (e.g., 🌵 🌿 🌸 🌻 🪴 🍀 🌱 🌾)
  - **Interval picker**: Every Day / Every 3 Days / Every Week / Every 2 Weeks / Every Month
  - **Last watered** defaults to today (do not show a date picker — just use `Date()`)
- A confirm button that adds the plant to the list

### Detail / Edit View (`PlantDetailView`)

- Tap a plant card to navigate to its detail view
- Inline editing for **name** and **interval**
- **"Mark as Watered"** button — resets `lastWatered` to today, updating the next due date
- **Delete** button at the bottom with a confirmation alert before removing the plant

---

## Starter Code

The repository includes boilerplate with a `Plant` model, a `PlantViewModel`, and stubbed-out views. Look for `// TODO:` comments — these mark every place you need to write code. You may add additional helper functions, view modifiers, and files as needed.

### File Structure

```
PlantWateringAssignment.xcodeproj
PlantWateringAssignment/
    PlantWateringAssignmentApp.swift
    Plant.swift
    PlantViewModel.swift
    Views/
        PlantListView.swift
        AddPlantView.swift
        PlantDetailView.swift
PlantWateringAssignmentTests/
PlantWateringAssignmentUITests/
README.md
```

---

## Submission

Submit a `.zip` of your completed Xcode project **and** a screen recording (under 1 minute) demonstrating:

1. Add 3 plants (with different intervals so one is overdue)
2. One card shows **red** with an overdue label
3. Tap it → **Mark as Watered** → watch it flip to **upcoming**
4. Rename another plant and change its interval
5. Delete the third plant using the confirmation alert

Upload your screen recording with your submission.
