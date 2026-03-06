# 🚗 Vehicle Management System (Flutter & Dart)

A **full-featured mobile application** built with **Flutter** to manage **Motorcycles, Cars, and Trucks**.  
The project demonstrates advanced **Object-Oriented Programming (OOP)** in Dart, featuring complete **CRUD functionality**, **search**, **insert at position**, **print details**, and **automatic JSON-based data persistence**.

---

## 📂 Project Structure

The project is organized into a clean, modular architecture:

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
│   ├── truck.dart              
│   └── vehicle.dart           
├── screens/
│   ├── car_screen.dart        
│   ├── motorcycle_screen.dart 
│   └── truck_screen.dart      
├── widgets/
│   ├── vehicle_form.dart       
│   └── vehicle_list.dart       
└── main.dart                  
```


## 🚀 Key Features

- **➕ Add, ✏️ Edit, 🗑 Delete vehicles**  
- **📍 Insert vehicles at a specific index in the list**  
- **🔍 Advanced Search by:**  
  - Manufacture Company  
  - Plate Number  
  - Manufacture Date  
- **🖨 Print individual or all vehicles**  
- **💾 Automatic data persistence using JSON**

---

## 🧠 Object-Oriented Architecture

- **Inheritance**: `Automobile → Vehicle → Car/Truck/Motorcycle`  
- **Encapsulation**: Private fields with getters & setters  
- **Polymorphism**: Overriding display and print methods  
- **Composition**: `Engine` object integrated into vehicle instances  

**Classes Included:**  
- `Engine`  
- `Automobile` (Base Class)  
- `Vehicle`  
- `Motorcycle`  
- `Car`  
- `Truck`  

---

## 🏍 Supported Vehicle Types

### **Cars**
- Number of Chairs  
- Leather interior option  
- Dimensions (Length & Width)  
- Engine Details  

### **Trucks**
- Free Weight & Full Weight  
- Dimensions  
- Engine Details  

### **Motorcycles**
- Tire Diameter & Length  
- Engine Details  

---

## 🖥 Application Screens

### **Home Screen**
- Overview of vehicle counts (Cars, Trucks, Motorcycles)  
- **🖨 Print All Vehicles button**  

### **Cars Screen**
- Full CRUD operations  
- Insert at a specific position  
- Search by Company, Plate Number, or Manufacture Date  
- Print individual car details  

### **Trucks Screen**
- Full CRUD operations  
- Insert at a specific position  
- Search by Company, Plate Number, or Manufacture Date  
- Print individual truck details  

### **Motorcycles Screen**
- Full CRUD operations  
- Insert at a specific position  
- Search by Company, Plate Number, or Manufacture Date  
- Print individual motorcycle details  

---

## 💾 Data Persistence

- JSON serialization using `dart:io` & `path_provider`  
- Data saved automatically on Add/Edit/Delete/Insert  
- Data loaded automatically when the app starts  

---

## ⚙️ Technologies Used

- **Flutter** – Mobile UI framework  
- **Dart** – OOP programming  
- **JSON encoding / decoding**  
- **Local file storage**  
- **OOP concepts**: Encapsulation, Inheritance, Polymorphism  

---

## 👤 Author

- **Naro8 Joma**  
- GitHub: [https://github.com/s12112343-cyber](https://github.com/s12112343-cyber)
