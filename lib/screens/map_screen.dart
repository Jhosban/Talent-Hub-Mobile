// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController mapController;
//   final LatLng _center = const LatLng(6.2518, -75.5636); // Medellín
//   Set<Marker> _markers = {};

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Estaciones de Carga',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF1A237E),
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           color: Color(0xFF1A237E),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: GoogleMap(
//               mapType: MapType.normal,
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: CameraPosition(
//                 target: _center,
//                 zoom: 13.0,
//               ),
//               markers: _markers,
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(16.0),
//             color: Colors.white,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Estación más cercana',
//                       style: TextStyle(fontSize: 18, color: Colors.grey),
//                     ),
//                     Text(
//                       '0.5 km',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1A237E),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'EcoCharge Centro',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF1A237E),
//                           ),
//                         ),
//                         Text(
//                           'Av. Principal 123',
//                           style: TextStyle(fontSize: 16, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                     FloatingActionButton(
//                       onPressed: () {},
//                       backgroundColor: Color(0xFF1A237E),
//                       child: Icon(Icons.navigation, color: Colors.white),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Icon(Icons.circle, color: Colors.green, size: 16),
//                     SizedBox(width: 8),
//                     Text(
//                       '4 cargadores disponibles',
//                       style: TextStyle(fontSize: 16, color: Colors.green),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

class ChargingStation {
  final String id;
  final String name;
  final String address;
  final LatLng location;
  final int availableChargers;
  final int totalChargers;
  final String type;
  final bool isOperational;

  ChargingStation({
    required this.id,
    required this.name,
    required this.address,
    required this.location,
    required this.availableChargers,
    required this.totalChargers,
    required this.type,
    required this.isOperational,
  });
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(6.2518, -75.5636); // Medellín
  Set<Marker> _markers = {};
  List<ChargingStation> _chargingStations = [];
  ChargingStation? _nearestStation;

  // Estaciones de ejemplo para Medellín
  final List<ChargingStation> _sampleStations = [
    ChargingStation(
      id: '1',
      name: 'EcoCharge Centro',
      address: 'Cra. 46 #52-45, La Candelaria',
      location: LatLng(6.2486, -75.5647),
      availableChargers: 4,
      totalChargers: 6,
      type: 'fast',
      isOperational: true,
    ),
    ChargingStation(
      id: '2',
      name: 'PowerStation El Poblado',
      address: 'Cra. 43A #5A-113, El Poblado',
      location: LatLng(6.2077, -75.5669),
      availableChargers: 2,
      totalChargers: 4,
      type: 'ultra',
      isOperational: true,
    ),
    ChargingStation(
      id: '3',
      name: 'VoltMax Laureles',
      address: 'Cra. 75 #65-87, Laureles',
      location: LatLng(6.2441, -75.5912),
      availableChargers: 0,
      totalChargers: 3,
      type: 'normal',
      isOperational: true,
    ),
    ChargingStation(
      id: '4',
      name: 'ChargePlus Envigado',
      address: 'Cra. 43A #34-95, Envigado',
      location: LatLng(6.1701, -75.5906),
      availableChargers: 3,
      totalChargers: 5,
      type: 'fast',
      isOperational: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadChargingStations();
    _findNearestStation();
  }

  void _loadChargingStations() {
    _chargingStations = _sampleStations;
    _createMarkers();
  }

  void _createMarkers() {
    Set<Marker> markers = {};

    // Agregar marcadores de estaciones
    for (ChargingStation station in _chargingStations) {
      markers.add(
        Marker(
          markerId: MarkerId(station.id),
          position: station.location,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            station.availableChargers > 0 
                ? BitmapDescriptor.hueGreen 
                : BitmapDescriptor.hueRed,
          ),
          infoWindow: InfoWindow(
            title: station.name,
            snippet: '${station.availableChargers}/${station.totalChargers} disponibles',
          ),
          onTap: () => _selectStation(station),
        ),
      );
    }

    setState(() {
      _markers = markers;
    });
  }

  void _selectStation(ChargingStation station) {
    setState(() {
      _nearestStation = station;
    });
  }

  void _findNearestStation() {
    if (_chargingStations.isEmpty) return;

    ChargingStation? nearest;
    double minDistance = double.infinity;

    for (ChargingStation station in _chargingStations) {
      if (!station.isOperational) continue;
      
      double distance = _calculateDistance(
        _center.latitude,
        _center.longitude,
        station.location.latitude,
        station.location.longitude,
      );

      if (distance < minDistance) {
        minDistance = distance;
        nearest = station;
      }
    }

    setState(() {
      _nearestStation = nearest;
    });
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371000; // metros
    double dLat = (lat2 - lat1) * pi / 180;
    double dLon = (lon2 - lon1) * pi / 180;
    
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * pi / 180) * cos(lat2 * pi / 180) *
        sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    
    return earthRadius * c;
  }

  String _formatDistance(double distanceInMeters) {
    if (distanceInMeters < 1000) {
      return '${distanceInMeters.round()} m';
    } else {
      return '${(distanceInMeters / 1000).toStringAsFixed(1)} km';
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  IconData _getChargerTypeIcon(String type) {
    switch (type) {
      case 'ultra':
        return Icons.flash_on;
      case 'fast':
        return Icons.bolt;
      default:
        return Icons.power;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Estaciones de Carga',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A237E),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF1A237E),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 13.0,
              ),
              markers: _markers,
            ),
          ),
          if (_nearestStation != null)
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Estación más cercana',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      Text(
                        _formatDistance(_calculateDistance(
                          _center.latitude,
                          _center.longitude,
                          _nearestStation!.location.latitude,
                          _nearestStation!.location.longitude,
                        )),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A237E),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  _getChargerTypeIcon(_nearestStation!.type),
                                  color: Color(0xFF1A237E),
                                  size: 20,
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    _nearestStation!.name,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1A237E),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              _nearestStation!.address,
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          // Navegación aquí
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Navegando a ${_nearestStation!.name}')),
                          );
                        },
                        backgroundColor: Color(0xFF1A237E),
                        child: Icon(Icons.navigation, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: _nearestStation!.availableChargers > 0
                            ? Colors.green
                            : Colors.red,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '${_nearestStation!.availableChargers} de ${_nearestStation!.totalChargers} cargadores disponibles',
                        style: TextStyle(
                          fontSize: 16,
                          color: _nearestStation!.availableChargers > 0
                              ? Colors.green
                              : Colors.red,
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
}