# 🚗 Vehicle Management System (Flutter & Dart)

A **full-featured mobile application** built with **Flutter** to manage **Motorcycles, Cars, and Trucks**.  
The project demonstrates advanced **Object-Oriented Programming (OOP)** in Dart, featuring complete **CRUD functionality**, **search**, **insert at position**, **print details**, and **automatic JSON-based data persistence**.

---

## 📂 Project Structure

```text
lib/
├── data/
│   └── vehicle_data.dart       # Handles JSON saving/loading of vehicles
├── models/
│   ├── automobile.dart         # Base class for all vehicles
│   ├── car.dart                # Car class extending Vehicle
│   ├── engine.dart             # Engine class with FuelType
│   ├── enums.dart              # FuelType & GearType enums
│   ├── motorcycle.dart         # Motorcycle class
│   └── vehicle.dart            # Vehicle base class
├── screens/
│   ├── car_screen.dart         # UI for managing Cars
│   ├── motorcycle_screen.dart  # UI for managing Motorcycles
│   └── truck_screen.dart       # UI for managing Trucks
├── widgets/
│   ├── vehicle_form.dart       # Form widget for Add/Edit vehicle
│   └── vehicle_list.dart       # List widget for displaying vehicles
└── main.dart                   # Main entry point of the app




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
 
