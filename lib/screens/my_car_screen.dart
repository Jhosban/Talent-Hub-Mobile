import 'package:flutter/material.dart';

class MyCarScreen extends StatefulWidget {
  const MyCarScreen({super.key});

  @override
  State<MyCarScreen> createState() => _MyCarScreenState();
}

class _MyCarScreenState extends State<MyCarScreen> {
  final List<Map<String, dynamic>> _vehicles = [
    {
      'name': 'Tesla Model 3',
      'image': 'https://paultan.org/image/2015/04/Tesla-Model-S-Blue-e1441956154254.jpg',
      'battery': 80,
      'range': 320,
    },
    {
      'name': 'Nissan Leaf',
      'image': 'https://www.nissanusa.com/content/dam/Nissan/us/vehicles/leaf/2023/overview/2023-nissan-leaf-sideview.jpg',
      'battery': 65,
      'range': 240,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A237E)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Mis Vehículos',
          style: TextStyle(
            color: Color(0xFF1A237E),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _vehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = _vehicles[index];
                  return _buildVehicleCard(vehicle);
                },
              ),
            ),
            _buildAddVehicleButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleCard(Map<String, dynamic> vehicle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Imagen del vehículo
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.network(
              vehicle['image'],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.directions_car, size: 80, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          // Información del vehículo
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vehicle['name'],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A237E),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    // Indicador de batería
                    Icon(Icons.battery_4_bar, color: Color(0xFF1A237E), size: 24),
                    Text(
                      '${vehicle['battery']}%',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 40),
                    // Indicador de autonomía
                    Icon(Icons.speed, color: Color(0xFF1A237E), size: 24),
                    const SizedBox(width: 4),
                    Text(
                      '${vehicle['range']} km',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddVehicleButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF1A237E), width: 2, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: Color(0xFF1A237E)),
              SizedBox(width: 8),
              Text(
                'Añadir nuevo vehículo',
                style: TextStyle(
                  color: Color(0xFF1A237E),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
