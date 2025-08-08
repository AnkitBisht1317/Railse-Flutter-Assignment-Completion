# 📋 Task Manager App (Flutter + Firebase)

This is a **Task Management App** built using Flutter and Firebase Firestore. The app is designed to help teams manage tasks by displaying a real-time list of tasks with their statuses, deadlines, priorities, and assignees.

---

## 🚀 Features

- 🔄 Real-time sync with Firebase Firestore
- 📅 Start Date & Due Date for each task
- ✅ Status management: Not Started, Started, Completed
- 🧑 Assignee and Priority fields per task
- 🎨 Status color indicators (Overdue, Completed, Upcoming)
- 🖱️ Buttons to **Start**, **Complete**, or **Edit** task
- 📱 Responsive design for mobile and tablets
- 🧠 Clean MVVM architecture using **Provider**

---

## 🧱 Architecture

This project follows the **MVVM (Model-View-ViewModel)** pattern:

- **Model** – Defines the task structure and maps Firestore data
- **View** – UI screens built with Flutter widgets
- **ViewModel** – Handles Firebase operations and state logic

---

## 🔧 Technologies Used

- **Flutter**
- **Firebase Firestore**
- **Provider** (for state management)
- **Intl** (for date formatting)

---

## 🗃️ Firebase Firestore Task Document Structure

Each task document includes the following fields:

```json
{
  "title": "Arrange Pickup",
  "description": "Pickup for Order-1043",
  "assignee": "Sandhya",
  "priority": "High",
  "status": "Not Started",
  "startDate": "2025-08-10T00:00:00.000+05:30",
  "dueDate": "2025-08-12T00:00:00.000+05:30"
}
```

---

## 📸 Screenshots

- ✅ Responsive card UI with all 6 fields
- 🔴 Color indicators for task status
- ✍️ Editable due/start date with date picker

---

## 📁 Folder Structure

```
lib/
├── model/          # Task model
├── viewmodel/      # Business logic
├── widgets/        # Reusable UI widgets (TaskCard)
└── screens/        # Main UI screen (TaskListScreen)
```

---

## ▶️ Getting Started

1. Clone the repo:
```bash
git clone https://github.com/your-username/task-manager-app.git
cd task-manager-app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Setup Firebase:
- Use FlutterFire CLI or add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS).
- Make sure Firestore has a collection named `tasks`.

4. Run the app:
```bash
flutter run
```

---


## 📄 License

This project is open-source and available under the [MIT License](LICENSE).
