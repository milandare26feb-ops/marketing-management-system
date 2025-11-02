import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../widgets/mapbox_map_view.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final GlobalKey<MapboxMapViewState> _mapKey = GlobalKey();
  Position? _currentPosition;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);
    
    try {
      // Check permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied');
        }
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      setState(() {
        _currentPosition = position;
      });

      // Move map to current location
      if (_mapKey.currentState != null) {
        await _mapKey.currentState!.moveCamera(
          position.latitude,
          position.longitude,
          zoom: 15.0,
        );
        await _mapKey.currentState!.addMarker(
          position.latitude,
          position.longitude,
          title: 'Current Location',
        );
      }

      print('✅ Current Location: ${position.latitude}, ${position.longitude}');
    } catch (e) {
      print('❌ Location Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get location: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapbox Map'),
        backgroundColor: const Color(0xFF2E5BFF),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _isLoading ? null : _getCurrentLocation,
          ),
        ],
      ),
      body: Stack(
        children: [
          MapboxMapView(
            key: _mapKey,
            onMapClick: (lat, lng) {
              print('Map clicked: $lat, $lng');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Clicked: ${lat.toStringAsFixed(4)}, ${lng.toStringAsFixed(4)}'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            onMapLongClick: (lat, lng) async {
              print('Map long clicked: $lat, $lng');
              await _mapKey.currentState?.addMarker(lat, lng, title: 'Marker');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Marker added!'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          if (_isLoading)
            Container(
              color: Colors.black26,
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E5BFF)),
                ),
              ),
            ),
          // Info card
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📍 Current Location',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (_currentPosition != null)
                      Text(
                        'Lat: ${_currentPosition!.latitude.toStringAsFixed(6)}\n'
                        'Lng: ${_currentPosition!.longitude.toStringAsFixed(6)}',
                        style: const TextStyle(fontSize: 14),
                      )
                    else
                      const Text('Fetching location...'),
                    const SizedBox(height: 8),
                    const Text(
                      'Tip: Long press to add marker',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
