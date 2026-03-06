# 🚗 Vehicle Management System (Flutter & Dart)

A **full-featured mobile application** built with **Flutter** to manage **Motorcycles, Cars, and Trucks**.  
The project demonstrates advanced **Object-Oriented Programming (OOP)** in Dart, featuring complete **CRUD functionality**, **search**, **insert at position**, **print details**, and **automatic JSON-based data persistence**.

---

## 📂 Project Structure
The project is organized into a clean, modular architecture as seen in the source code:
```text
lib/
├── data/
│   └── vehicle_data.dart      # Logic for JSON serialization & local File I/O
├── models/
│   ├── automobile.dart        # Abstract base class for the hierarchy
│   ├── car.dart               # Car model with specific attributes (Chairs, Leather)
│   ├── engine.dart            # Engine specifications (FuelType, CC)
│   ├── enums.dart             # Application-wide Enums (FuelType, GearType)
│   ├── motorcycle.dart        # Motorcycle model (Tire Diameter, Length)
│   ├── truck.dart             # Truck model (Weight capacities, Dimensions)
│   └── vehicle.dart           # Unified vehicle properties
├── screens/
│   ├── car_screen.dart        # UI for managing Cars (CRUD + Search)
│   ├── motorcycle_screen.dart # UI for managing Motorcycles
│   └── truck_screen.dart      # UI for managing Trucks
└── main.dart                  # Application entry point & Dashboard

```text


---

## 🚀 Features

- **Add, Edit, Delete** vehicles  
- **Insert at specific position** in the list  
- **Search** by:
  - Manufacture Company  
  - Plate Number  
  - Manufacture Date  
- **Print individual or all vehicles**  
- Automatic **JSON-based local storage**  

---

## 🏍 Supported Vehicle Types

**Cars**
- Chair Number & Leather Interior  
- Dimensions & Engine Details  

**Trucks**
- Free Weight & Full Weight  
- Dimensions & Engine Details  

**Motorcycles**
- Tire Diameter & Length  
- Engine Details  

---

## 🖥 Screens

**Cars Screen** – CRUD + Insert + Search + Print  
**Trucks Screen** – CRUD + Insert + Search + Print  
**Motorcycles Screen** – CRUD + Insert + Search + Print  

---

## 💾 Data Persistence

- JSON serialization with `dart:io` & `path_provider`  
- Data saved automatically on Add/Edit/Delete/Insert  
- Data loaded automatically on app start  

---

## ⚙️ Technologies

- **Flutter** – UI  
- **Dart** – OOP programming  
- **JSON encoding / decoding**  
- **Local file storage**  
- **OOP concepts**: Encapsulation, Inheritance, Polymorphism  

---
 
