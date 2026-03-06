# 🚗 Vehicle Management System (Flutter & Dart)

A **full-featured mobile application** built with Flutter to manage **Motorcycles, Cars, and Trucks**. This project demonstrates advanced **Object-Oriented Programming (OOP)** principles in Dart, featuring complete **CRUD functionality**, **search**, and **automatic data persistence**.

---

## 📂 Project Structure

The project follows a clean directory structure as shown in the source code:

```text
lib/
├── data/
│   └── vehicle_data.dart     
├── models/
│   ├── automobile.dart        
│   ├── car.dart              
│   ├── engine.dart            
│   ├── enums.dart            
│   ├── motorcycle.dart       
│   └── vehicle.dart          
├── screens/
│   ├── car_screen.dart        
│   ├── motorcycle_screen.dart
│   └── truck_screen.dart     
└── main.dart

📌 Key Features
➕ Full CRUD Operations: Add, Edit, and Delete vehicles with ease.

📍 Insert at Position: Capability to insert a vehicle at a specific index in the list.

🔍 Smart Search: Filter vehicles dynamically by:

Manufacture Company

Plate Number

Manufacture Date

💾 Data Persistence: Automatic saving and loading using JSON serialization via path_provider.

🖨️ Print Details: Generate console or UI reports for individual or all vehicles.

🧠 OOP Implementation
This system is a practical implementation of core OOP concepts:

Inheritance: Structured hierarchy from Automobile → Vehicle → Specific Types.

Encapsulation: Data protection using private fields and custom getters/setters.

Polymorphism: Overriding methods for specialized vehicle behavior.

Composition: Integrating the Engine class within vehicle models.

⚙️ Technologies Used
Flutter: UI Framework for a responsive mobile experience.

Dart: Programming language for logic and data modeling.

JSON: For structured local data storage.

Path Provider: To handle filesystem locations across devices.


🚀 How to Run
Clone the repository:

Bash
git clone [https://github.com/s12112343-cyber/Your-Repo-Name.git](https://github.com/s12112343-cyber/Your-Repo-Name.git)
Install dependencies:

Bash
flutter pub get
Run the application:

Bash
flutter run
