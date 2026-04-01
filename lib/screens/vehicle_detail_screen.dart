import 'package:flutter/material.dart';
import '../models/car.dart';
import '../models/truck.dart';
import '../models/motorcycle.dart';
import '../models/enums.dart';
import 'package:intl/intl.dart';

class VehicleDetailScreen extends StatelessWidget {
  final dynamic vehicle;

  const VehicleDetailScreen({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    String title;
    IconData icon;
    Color color;

    if (vehicle is Car) {
      title = 'Car Details';
      icon = Icons.directions_car;
      color = Colors.green;
    } else if (vehicle is Truck) {
      title = 'Truck Details';
      icon = Icons.local_shipping;
      color = Colors.orange;
    } else if (vehicle is Motorcycle) {
      title = 'Motorcycle Details';
      icon = Icons.two_wheeler;
      color = Colors.purple;
    } else {
      title = 'Vehicle Details';
      icon = Icons.help;
      color = Colors.grey;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: color,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with icon
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              color: color.withOpacity(0.1),
              child: Column(
                children: [
                  Icon(icon, size: 80, color: color),
                  const SizedBox(height: 16),
                  Text(
                    '${vehicle.manufactureCompany} ${vehicle.model}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Basic Information (from Automobile)
            _buildSection('Basic Information', [
              _buildDetailRow('ID', vehicle.id?.toString() ?? 'N/A'),
              _buildDetailRow(
                  'Manufacture Company', vehicle.manufactureCompany),
              _buildDetailRow('Model', vehicle.model),
              _buildDetailRow(
                'Manufacture Date',
                DateFormat('MMM dd, yyyy').format(vehicle.manufactureDate),
              ),
              _buildDetailRow('Plate Number', vehicle.plateNum.toString()),
              _buildDetailRow(
                  'Body Serial Number', vehicle.bodySerialNum.toString()),
              _buildDetailRow(
                'Gear Type',
                vehicle.gearType == GearType.automatic ? 'Automatic' : 'Normal',
              ),
            ]),

            // Vehicle-specific fields (length, width, color)
            if (vehicle is Car || vehicle is Truck) ...[
              _buildSection('Physical Attributes', [
                _buildDetailRow('Length', '${vehicle.length} m'),
                _buildDetailRow('Width', '${vehicle.width} m'),
                _buildDetailRow('Color', vehicle.color),
              ]),
            ],

            // Car-specific fields
            if (vehicle is Car) _buildCarSpecificSection(vehicle as Car),

            // Truck-specific fields
            if (vehicle is Truck) _buildTruckSpecificSection(vehicle as Truck),

            // Motorcycle-specific fields
            if (vehicle is Motorcycle)
              _buildMotorcycleSpecificSection(vehicle as Motorcycle),

            // Engine Information
            _buildSection('Engine Information', [
              _buildDetailRow('Manufacturer', vehicle.engine.manufacture),
              _buildDetailRow('Model', vehicle.engine.model),
              _buildDetailRow(
                'Manufacture Date',
                DateFormat('MMM dd, yyyy')
                    .format(vehicle.engine.manufactureDate),
              ),
              _buildDetailRow('Capacity', '${vehicle.engine.capacity} cc'),
              _buildDetailRow('Cylinders', vehicle.engine.cylinders.toString()),
              _buildDetailRow(
                'Fuel Type',
                vehicle.engine.fuelType == FuelType.diesel
                    ? 'Diesel'
                    : 'Gasoline',
              ),
            ]),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(children: children),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarSpecificSection(Car car) {
    return _buildSection('Car-Specific Details', [
      _buildDetailRow('Vehicle Type', 'Car'),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          'This vehicle is a passenger car designed for comfort and efficiency.',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    ]);
  }

  Widget _buildTruckSpecificSection(Truck truck) {
    // 🔥 استخدم freeWeight بدلاً من emptyWeight
    final cargoCapacity = truck.fullWeight - truck.freeWeight;

    return _buildSection('Truck-Specific Details', [
      _buildDetailRow('Vehicle Type', 'Truck'),
      _buildDetailRow('Full Weight', '${truck.fullWeight} kg'),
      _buildDetailRow('Free Weight', '${truck.freeWeight} kg'),
      _buildDetailRow(
          'Cargo Capacity', '${cargoCapacity.toStringAsFixed(2)} kg'),
    ]);
  }

  Widget _buildMotorcycleSpecificSection(Motorcycle motorcycle) {
    return _buildSection('Motorcycle-Specific Details', [
      _buildDetailRow('Vehicle Type', 'Motorcycle'),
      _buildDetailRow('Tire Diameter', '${motorcycle.tierDiameter} inches'),
      _buildDetailRow('Length', '${motorcycle.length} m'),
    ]);
  }
}
